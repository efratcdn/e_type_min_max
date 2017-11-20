File name     : e_util_type_min_max.e
Title         : Type MIN/MAX Value
Project       : Utilities examples
Created       : 2017
Description   : 
              : The macros MIN_VALUE and MAX_VALUE return the min/max value 
              : of a type. 
              : RANGE_SIZE returns the size of the range of the type, how many 
              : values there are of this type.
              :
              : Can be called not in the same module in which the type was 
              : defined. 
Notes         : 
              : Providing here two variations - using define as, and 
              : define as computed. You can create your own macro, based on
              : expected usage
              :
Prerequisites : Specman 17.04 (or newer)
              :
Example       : See usage example e_util_type_min_max_usage_ex.e
              : Running:
              :  (add this directory to SPECMAN_PATH)
        
   specman -c 'load type_min_max_usage_ex.e; test; show cover monitor.ended'

--------------------------------------------------------------------------- 
//----------------------------------------------------------------------
//   Copyright 2017 Cadence Design Systems, Inc.
//   All Rights Reserved Worldwide
//
  
  
define as, the better implementation when the type are numeric
  

<'

define <e_util_min_value'exp> "MIN_VALUE[ ]\(<type>\)" as {
    set_of_values(<type>).uint_min().as_a(<type>); 
};

define <e_util_max_value'exp> "MAX_VALUE[ ]\(<type>\)" as {        
    set_of_values(<type>).uint_max().as_a(<type>);  
};

define <e_util_type_range'exp> "RANGE_SIZE[ ]\(<type>\)" as {      
    set_of_values(<type>).uint_size();   
};
'>

  
define as computed, the better implementation when the type is numeric

so - if numeric - handle in the DAC, if not - reject, to be handled by the define as.

<'

define <e_util_min_value_dac'exp> "MIN_VALUE[ ]\(<type>\)" as computed {        
    var the_type := rf_manager.get_type_by_name(<type>);
   
    if the_type is a rf_numeric (rfn) {
        // numeric type
        var set = rfn.get_set_of_values();
        if rfn.is_longint() {    
            // for longint. must use min/max methods, 
            return set.min().to_string();
        } else {
            // <= 32 bits, can use the [u]int_min/max, better performance
            if rfn.is_signed() {
                // int
                return set.int_min().to_string();
            } else {
                // uint
                return set.uint_min().to_string();
            };
        };
    } else {
        // not a numeric, let the 'define as' to handle this
        reject_match();
    };
};


define <e_util_max_value_dac'exp> "MAX_VALUE[ ]\(<type>\)" as computed {      
    var the_type := rf_manager.get_type_by_name(<type>);
   
    if the_type is a rf_numeric (rfn) {
        // numeric type
        var set = rfn.get_set_of_values();
                
        if rfn.is_longint() {    
            // for longint. must use max/max methods, 
            return set.max().to_string();
        } else {
            // <= 32 bits, can use the [u]int_max/max, better performance
            if rfn.is_signed() {
                // int
                return set.int_max().to_string();
            } else {
                // uint
                return set.uint_max().to_string();
            };
        };
    } else {
        // not a numeric, let the 'define as' to handle this
        reject_match();
    };      
};



define <e_util_type_range_dac'exp> "RANGE_SIZE[ ]\(<type>\)" as computed {      
    var the_type: rf_numeric = rf_manager.get_type_by_name(<type>).as_a(rf_numeric);
    if the_type is a rf_numeric (rfn) {
        // numeric type
        var set = rfn.get_set_of_values();
        return set.size().to_string();
    } else {
        // not a numeric, let the 'define as' to handle this
        reject_match();
    }; 
};



'>


