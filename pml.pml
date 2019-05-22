FILE markup:
  HAS: code

PROGRAM pml:
  HAS:
    CLASS PMLObject:
      HAS:
        VALUE dictionary TYPE dict
        VALUE description TYPE str
        VALUE pml_code TYPE str
        VALUE has TYPE list<str>
        VALUE does TYPE list<str>
        VALUE calls TYPE list<str>
        VALUE returns TYPE list<str>
        VALUE extends TYPE list<str>
        VALUE refers TYPE list<str>
        VALUE modifies TYPE list<str>
    CLASS PMLReference EXTENDS PMLObject:
      DESCRIPTION:
        Reference to other PML objects in a PML script.
        e.g. "CALLS calc(lhs,rhs) RETURNS val" should be interpreted as "calc" and "val" being a PMLReference.
        calc.param = "PMLReference lhs, PMLReference rhs"
        val.type = "int"
        val.call_by = "VALUE"
      HAS:
        REFERENCE refers TYPE PMLObject
        VALUE type TYPE str
        VALUE name TYPE str
        VALUE call_by TYPE str
    CLASS PMLVariable EXTENDS PMLObject:
      HAS:
        VALUE call_by TYPE str
        VALUE access_modifier TYPE str
        VALUE 
    CLASS CodeBlock:
      HAS:
        VALUE code TYPE list
      DOES:
        
  DOES:
    METHOD parse(file REFERENCE f):
      DESCRIPTION:
        Parses file into lines of PML code.
      RETURNS: list
    METHOD get_indent(str REFERENCE s):
      DESCRIPTION:
        gets indent value (number of leading spaces) of a string.
      RETURNS: VALUE int
    METHOD indent(list REFERENCE l):
      DESCRIPTION:
        groups code by indented and not indented.
        then sends indented code recursively.
      HAS:
        VALUE code TYPE list
        VALUE indented TYPE list<list REFERENCE>:
          DESCRIPTION:
            group of indented strings that are called by reference to "code"
      CALLS:
        indent(indented) MODIFIES code, indented
    METHOD main:
      DESCRIPTION:
      HAS:
        VALUE filename TYPE str
        VALUE code TYPE list
        VALUE f TYPE file
      CALLS:
        __builtin__.input() RETURNS filename
        __builtin__.open() RETURNS f
        parse(f) MODIFIES code
      REFERS filename, code, f
        
      
  
  
