create or replace package pit_jet
  authid definer
as
  

  /** Method to retrieve a JSON object describing the oj modules avialable
   * %return JSON object of structure [{id, name, iconClass},...]
   * %usage  Is used to generate a navigation bar for the one page applcation
   */
  function get_nav_bar
    return varchar2;

end pit_jet;
/