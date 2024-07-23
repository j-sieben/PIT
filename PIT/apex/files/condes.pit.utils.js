var condes = condes || {};
condes.pit = condes.pit || {};
condes.pit.utils = {};

(function(util){

  const C_CUSTOM_ERROR = '-20000';
  const C_ITEM_CUSTOM_ERROR = 'P3_PMS_CUSTOM_ERROR';
  const C_ITEM_ERROR_TYPE = 'P3_PMS_ERROR_TYPE';
  const C_ITEM_REQUIRES_EXCEPTION = 'P3_H_REQUIRES_EXCEPTION';

  util.controlExportItems = function(){

    apex.item('EXPORT_PMS').disable();
    apex.item('TRANSLATE_PMS').disable();
    apex.item('EXPORT_PAR').disable();
    apex.item('TRANSLATE_PTI').disable();
    apex.item('EXPORT_PTI').disable();
    
    if (apex.item('P16_PMS_PMG_LIST').getValue() != ""){
      apex.item('EXPORT_PMS').enable();
      if (apex.item('P16_PMS_PML_NAME').getValue() != ""){
        apex.item('TRANSLATE_PMS').enable();
      }
    };
    
    if (apex.item('P16_PTI_PMG_LIST').getValue() != ""){
      apex.item('EXPORT_PTI').enable();
      if (apex.item('P16_PTI_PML_NAME').getValue() != ""){
        apex.item('TRANSLATE_PTI').enable();
      }
    };
    
    if (apex.item('P16_PAR_PGR_LIST').getValue() != ""){
      apex.item('EXPORT_PAR').enable();
    }
  };

  util.controlErrorSeverity = function(){
    const prequiresException = apex.item(C_ITEM_REQUIRES_EXCEPTION).getValue();
    let errorType;
    // Refresh list of value to filter impossible settings
    apex.item(C_ITEM_ERROR_TYPE).refresh();

    switch (prequiresException){
      case 'NONE':
        apex.item(C_ITEM_ERROR_TYPE).hide();
        errorType ='NONE';
        break;
      case 'OPTIONAL':
        apex.item(C_ITEM_ERROR_TYPE).show();
        errorType ='CUSTOM';
        break;
      case 'MANDATORY':
        apex.item(C_ITEM_ERROR_TYPE).show();
        errorType ='ORACLE';
        break;
    };

    // Delay setting of C_IREM_ERROR_TYPE until refresh has come back
    $('#' + C_ITEM_ERROR_TYPE).one('apexafterrefresh', function(){apex.item(C_ITEM_ERROR_TYPE).setValue(errorType);})
  };

    /**
      Function: predefineErrorTypeIfNull
        Method checks whether errorType is set. If not, it is preset based on the customError setting passed in

      Parameter:
        pCustomError - Error number as set in the database. If -20000, CUSTOM type is assumed, if not NULL, ORACLE type is assumed and NONE otherwise.
     */
  predefineErrorTypeIfNull = function(pCustomError){
    let errorType = apex.item(C_ITEM_ERROR_TYPE).getValue();

    if(errorType.length == 0){
      switch (pCustomError){
        case C_CUSTOM_ERROR:
          errorType = 'CUSTOM';
          break;
        case '':
          errorType = 'NONE';
          break;
        default:
          errorType = 'ORACLE';
      };
      apex.item(C_ITEM_ERROR_TYPE).setValue(errorType);
    };

    return errorType;
  };

  util.controlErrorTypeSetting = function(){
    const customError = apex.item(C_ITEM_CUSTOM_ERROR).getValue();
    const errorType = predefineErrorTypeIfNull(customError);

    switch (errorType){
      case 'NONE':
        apex.item(C_ITEM_CUSTOM_ERROR).setValue();
        apex.item(C_ITEM_CUSTOM_ERROR).hide();
        break;
      case 'CUSTOM':
        apex.item(C_ITEM_CUSTOM_ERROR).setValue(C_CUSTOM_ERROR);
        apex.item(C_ITEM_CUSTOM_ERROR).hide();
        break;
      case 'ORACLE':
        if (customError == C_CUSTOM_ERROR){
          apex.item(C_ITEM_CUSTOM_ERROR).setValue();
        };
        apex.item(C_ITEM_CUSTOM_ERROR).show();
        break;
    };
  };
})(condes.pit.utils);