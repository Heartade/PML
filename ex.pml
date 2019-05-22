PROGRAM example:
  HAS:
    #PUBLIC CLASS exampleClass:
      EXTENDS:
        CLASS exampleParent
      DOES:
        #PUBLIC METHOD exampleMethod:
          HAS:
            #VALUE VAR ret:
              TYPE int
          RETURNS:
            #VALUE TYPE int

different styles
HAS:
  #VALUE VAR ret:
    TYPE int
  #VALUE VAR ret: TYPE int
  #VALUE VAR ret: int
  #VALUE ret: int
  VALUE ret: TYPE int
  VALUE ret TYPE int
RETURNS:
  #VALUE TYPE int
  VALUE TYPE int
  VALUE int
