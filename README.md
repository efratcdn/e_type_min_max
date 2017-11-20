# e_type_min_max
e Macros for Type min / max values
* Title       : Type MIN/MAX Value 
* Version     : 1.0
* Requires    : Specman {17.04..}
* Modified    : Novemeber 2017
* Description :

The macros implemented in e_util_type_min_max.e can be used as is, or as an example - you 
can download, and edit per your requirements/methdology.


The macros MIN_VALUE and MAX_VALUE return the min/max value of a type.
 
RANGE_SIZE returns the size of the range of the type, how many values there are of this type.
In the example, this is used for defining buckets for a coverage item of type integer.
              
The macros can be called not in the same module in which the type was defined. 


Providing here two variations - using define as, and define as computed. 
The define as computed is better in handling numeric type (variants of int and uint), and the define-as
are better in handling enums. 
