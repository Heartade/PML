PROGRAM pml:
  HAS:
    VAR names:
      TYPE dict
        all the objects in this program.
    VAR types:
      DESCRIPTION:
        all the 'type's in this program.
      TYPE dict
    CLASS PMLObject:
      HAS:
        !VALUE VAR attributes:
          TYPE dict
        !VALUE VAR tags:
          TYPE list
      DOES:
        METHOD describe:
          DESCRIPTION:
            describes an objects. prints given description if possible.
        !PUBLIC METHOD get:
          PARAM:
            VAR attr_name
          RETURNS:
            VAR super.attributes[attr_name]
        !PUBLIC METHOD set:
          PARAM:
            VAR attr_name
            VAR attr_val
          MODIFIES:
            VAR super.attributes
        !PUBLIC METHOD __init__:
          DESCRIPTION:
            first checks if the object already exists in dictionary and if false, creates one; if true, updates.
          PARAM:
            !REFERENCE VAR self:
              TYPE PMLObject
          MODIFIES:
            VAR super.attributes
            VAR super.tags
          RETURNS:
            !REFERENCE TYPE PMLObject
        !PUBLIC METHOD from_list:
          PARAM:
            !REFERENCE VAR self:
              TYPE PMLObject
            !REFERENCE VAR l:
              DESCRIPTION:
                list of code.
              TYPE list
    CLASS Parser:
      DOES:
        !PUBLIC !STATIC METHOD get_indent:
          PARAM:
            !VALUE VAR s:
              TYPE str
          RETURNS:
            !VALUE TYPE int

        !PUBLIC !STATIC METHOD indent:
          PARAM:
            !VALUE VAR l:
              TYPE list
          HAS:
            VAR indented:
              TYPE list
            VAR ret:
              TYPE list
            VAR initial_indent:
              TYPE int
            VAR i:
              TYPE int
            VAR new_block:
              TYPE list
          CALLS:
            METHOD indent:
              PARAM:
                VAR l
              RETURNS:
                VAR ret:
                  TYPE list
          RETURNS:
            !REFERENCE VAR ret:
              TYPE list

        !PUBLIC !STATIC METHOD print_indented:
          DESCRIPTION:
            Prints the list in indented format.
          PARAM:
            !VALUE VAR s:
              TYPE str
            !REFERENCE VAR l:
              TYPE list
