create or replace package pit_test_cases
as

  /* Test case for toggle context functionality
   * %usage Tests, whether a method toggles tracing on and off correctly
   *        Test flow:
   *        - call proc with default logging
   *        - call proc with toggle on
   *        Expectation:
   *        - Context gets switched when entering TOGGLE ON immediately
   *        - Context gets back to default after leaving toggle method
   */
  procedure toggle_context_1;
  
  
  /* Test case for toggle context functionality
   * %usage Tests, whether a method toggles tracing on and off correctly
   *        Test flow:
   *        - call proc with default logging
   *        - set context to LOG_ONLY
   *        - call proc with TOGGLE ON
   *        Expectation:
   *        - Context gets switched to LOG_ONLY
   *        - Context gets switched on when entering TOGGLE ON immediately
   *        - Context gets back to LOG_ONLY after leaving toggle method
   */
  procedure toggle_context_2;
  
  
  /* Test case for toggle context functionality
   * %usage Tests, whether a method toggles tracing on and off correctly
   *        Test flow:
   *        - call proc with default logging
   *        - call proc with TOGGLE ON
   *        - call proc with TOGGLE_OFF
   *        Expectation:
   *        - Context gets switched on when entering TOGGLE ON immediately
   *        - Context gets switched off when entering TOGGLE_OFF immediately
   *        - Context gets switched on when entering TOGGLE_ON again
   *        - Context gets back to default after leaving TOGGLE ON method
   */
  procedure toggle_context_3;
  
  
  /* Test case to prove that errors get thrown no matter what the log settings are
   * %usage Tests, whether a method fires an error correctly
   *        Test flow:
   *        - set context to TEST_OFF
   *        - call PIT.ERROR
   *        Expectation:
   *        - ERROR gets thrown and captured
   */
  procedure catch_error_anyway;
  
  
  /* Test case to prove that errors get thrown no matter what the log settings are
   * %usage Tests, whether a method fires an error correctly
   *        Test flow:
   *        - set context to TEST_OFF
   *        - call PIT.ERROR
   *        Expectation:
   *        - ERROR gets thrown and re-raised to calling environment
   */
  procedure catch_fatal_and_stop;
  
end pit_test_cases;
/