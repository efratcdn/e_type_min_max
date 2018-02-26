# e_type_min_max
e Macros for Type min / max values
* Title       : Type MIN/MAX Value 
* Version     : 1.0
* Requires    : Specman {17.04..}
* Modified    : Novemeber 2017
* Description :

[  More e code examples in https://github.com/efratcdn/spmn-e-utils ]

The macros implemented in e_util_type_min_max.e can be used as is, or as an example - you 
can download, and edit per your requirements/methdology.


The macros MIN_VALUE and MAX_VALUE return the min/max value of a type.
 
RANGE_SIZE returns the size of the range of the type, how many values there are of this type.
In the example, this is used for defining buckets for a coverage item of type integer.
              
The macros cannot be called in the same module in which the type was defined. 


Providing here two variations - using define as, and define as computed. 
The define as computed is better in handling numeric type (variants of int and uint).
The define-as are better in handling enums. 
enum type can be extended in a later module, so the define-as, perforing the min/max 
calculation during the run - gives the accurate result. The define-as-computed performs 
the calculation when the file is loaded, if a type is extended in a later module -
the min/max values will be wrong.

Files:
- e_util_type_min_max.e : the macros implementation
- type_min_max_usage_ex.e : usage example of the macro
- types_def_usage_ex.e : type definition file, used in the example

Running the example:

  specman -c 'load type_min_max_usage_ex.e; test; show cover monitor.ended; sys.print_types()'
