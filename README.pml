LANGUAGE PML:
  DESCRIPTION:
    PML, Programmer's Markup Language, is a documentation format which is
    easier to read for programmers and harder to read for people.
  HAS:
    CLASS PMLObject:
      DESCRIPTION:
        Everything in PML is a PMLObject, which HAS, DOES, CALLS, etc, all the things which are also PMLObjects.
      HAS:
        VAR attributes:
          DESCRIPTION:
            All the attributes a PML Object has. Even "HAS" is an attribute.
          TYPE dict
          HAS:
            VAR _OBJTYPE:
              TYPE str
              DESCRIPTION:
                Whether the object is a METHOD, CLASS, FUNCTION…
                Different from TYPE in that TYPE stands for data type.
            VAR NAME:
              TYPE str
              DESCRIPTION:
                Name. Simple.
            VAR DESCRIPTION
              TYPE str
            VAR EXTENDS
              TYPE list<CLASS>
            VAR PARAM
              TYPE list<VAR>
            VAR HAS:
              TYPE list<PMLObject>
            VAR DOES:
              TYPE list<METHOD>
            VAR REFERS:
              TYPE list<!REFERENCE VAR>
            VAR MODIFIES:
              TYPE list<!REFERENCE VAR>
            VAR CALLS:
              TYPE list<METHOD>
      DOES:
        !PUBLIC METHOD GET:
          PARAM:
            VAR attr_name:
              DESCRIPTION:
                name of the attribute to look for.
          REFERS:
            super.attributes
          RETURNS:
            VAR attr_val:
              DESCRIPTION:
                value of the attribute.
          RAISES:
            ERROR KeyError
