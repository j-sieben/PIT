#!/usr/bin/env python3
"""Check handbook links and first glossary mentions; optionally add glossary links."""
import argparse
from pathlib import Path
import re
from urllib.parse import unquote
import os

ROOT = Path(__file__).resolve().parents[1]
TERMS = {
    'message-group': r'message groups?',
    'message-argument': r'message arguments?',
    'translatable-item': r'translatable items?',
    'output-module': r'output modules?',
    'fire-threshold': r'fire thresholds?',
    'session-adapter': r'session adapters?',
    'collection-mode': r'collection mode',
    'error-code': r'error codes?',
    'affected-reference': r'affected (?:object )?references?',
    'dynamic-call-stack': r'dynamic (?:call )?stack',
    'instrumented-call-stack': r'instrumented (?:call )?stack',
    'error-stack': r'error stack',
    'exception-backtrace': r'exception backtrace',
    'log-level': r'log levels?',
    'trace-level': r'trace levels?',
    'context-toggle': r'context toggles?',
    'context': r'contexts?',
    'severity': r'severit(?:y|ies)',
    'assertion': r'assertions?',
    'realm': r'realms?',
    'parameter': r'parameters?',
    'message': r'messages?',
    'exception': r'exceptions?',
    'publication': r'publication',
    'xliff': r'XLIFF',
    'icu': r'ICU(?: message)?',
}
TERM_RE = re.compile(r'\b(?:' + '|'.join(f'(?P<t{i}>{p})' for i, p in enumerate(TERMS.values())) + r')\b', re.I)
KEYS = list(TERMS)
LINK_RE = re.compile(r'!?\[([^\]]*)\]\(([^)]+)\)')
TOKEN_RE = re.compile(r'`+[^`]*`+|!?\[[^\]]*\]\([^)]+\)|' + TERM_RE.pattern, re.I)


def pages():
    return [ROOT / 'README.md'] + sorted((ROOT / 'DOC').glob('*.md')) + sorted((ROOT / 'DOC/obsidian').rglob('*.md'))


def prose_lines(text):
    fenced = False
    for n, line in enumerate(text.splitlines(keepends=True), 1):
        if re.match(r'^\s*(```|~~~)', line):
            fenced = not fenced
            yield n, line, False
        else:
            yield n, line, not fenced and not line.startswith('#')


def glossary_mentions(path, text, fix=False):
    seen = {path.stem} if path.parent.name == 'glossary' else set()
    errors, result = [], []
    for n, line, eligible in prose_lines(text):
        if not eligible:
            result.append(line)
            continue
        def replace(match):
            token = match.group()
            link = LINK_RE.fullmatch(token)
            if link:
                target = link.group(2).split('#')[0]
                if 'glossary/' in target or path.parent.name == 'glossary':
                    if Path(target).stem in TERMS:
                        seen.add(Path(target).stem)
                return token
            if token.startswith('`'):
                return token
            term = TERM_RE.fullmatch(token)
            if not term:
                return token
            key = KEYS[int(term.lastgroup[1:])]
            if key in seen:
                return token
            seen.add(key)
            target = ROOT / 'DOC/obsidian/glossary' / (key + '.md')
            relative = os.path.relpath(target, path.parent)
            errors.append(f'{path.relative_to(ROOT)}:{n}: first mention of {key} needs a glossary link')
            return f'[{token}]({relative})' if fix else token
        result.append(TOKEN_RE.sub(replace, line))
    return ''.join(result), errors


def slug(heading):
    heading = re.sub(r'`([^`]+)`', r'\1', heading).lower().strip()
    heading = re.sub(r'[^\w\- ]', '', heading)
    return heading.replace(' ', '-')


def anchors(path):
    found, counts = set(), {}
    for _, line, _ in prose_lines(path.read_text()):
        # Headings are deliberately excluded from glossary linking, but own anchors.
        if re.match(r'^#{1,6} ', line):
            key = slug(re.sub(r'^#+\s+', '', line))
            count = counts.get(key, 0)
            counts[key] = count + 1
            found.add(key + (f'-{count}' if count else ''))
    return found


def check_links(path, text):
    errors = []
    fenced = False
    for n, line in enumerate(text.splitlines(), 1):
        if re.match(r'^\s*(```|~~~)', line):
            fenced = not fenced
            continue
        if fenced:
            continue
        for match in LINK_RE.finditer(line):
            href = match.group(2)
            if re.match(r'^[a-zA-Z][\w+.-]*:', href):
                continue
            href, _, anchor = unquote(href).partition('#')
            target = Path(os.path.abspath(path.parent / href)) if href else path
            if not target.exists():
                errors.append(f'{path.relative_to(ROOT)}:{n}: missing target {match.group(2)}')
                continue
            # Check each component because the development filesystem may ignore case.
            current = ROOT
            try:
                parts = target.relative_to(ROOT).parts
            except ValueError:
                errors.append(f'{path.relative_to(ROOT)}:{n}: link escapes repository')
                continue
            for part in parts:
                if part not in {p.name for p in current.iterdir()}:
                    errors.append(f'{path.relative_to(ROOT)}:{n}: incorrect path casing {href}')
                    break
                current /= part
            if anchor and target.suffix == '.md' and anchor not in anchors(target):
                errors.append(f'{path.relative_to(ROOT)}:{n}: missing anchor {anchor}')
    return errors


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--fix-glossary', action='store_true', help='link the first prose mention of each defined term')
    args = parser.parse_args()
    errors = []
    for path in pages():
        text = path.read_text()
        updated, mentions = glossary_mentions(path, text, args.fix_glossary)
        if args.fix_glossary and updated != text:
            path.write_text(updated)
        if not args.fix_glossary:
            errors.extend(mentions)
        errors.extend(check_links(path, updated))
    if errors:
        print('\n'.join(errors))
        return 1
    print(f'Checked {len(pages())} Markdown pages: local links, anchors, path casing and glossary mentions are valid.')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
