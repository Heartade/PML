names = {}
types = {}
name_of_types = ['CLASS', 'METHOD', 'FUNCTION', 'PROGRAM']
class PMLObject:
  def __init__(self,parent = None):
    self.parent = parent
    self.tags = []
    self.attributes = {}
  def name(self):
    return self.attributes['NAME']
  def objtype(self):
    return self.attributes['_OBJTYPE']
  def get(self, attr_name):
    return self.attributes[attr_name]
  def describe(self):
    if 'DESCRIPTION' in self.attributes:
      print(self.attributes['DESCRIPTION'])
    self.print_attrs()
  def set(self, attr_name, attr_val):
    if attr_name in self.attributes:
      if attr_name != 'NAME' and attr_name != '_OBJTYPE':
        self.attributes[attr_name] += attr_val
    else:
      self.attributes[attr_name] = attr_val
      if attr_name == 'NAME':
        if self.get('_OBJTYPE') in name_of_types:
          types[attr_val] = self
  def print_attrs(self):
    print('ATTRIBUTES OF '+self.attributes['NAME']+':')
    for key in self.attributes:
      print(key)
  def print_info(self,key):
    print(self.attributes['_OBJTYPE'] + ' ' + self.attributes['NAME'])
    print(key+':')
    for value in self.attributes[key]:
      print('  '+value.objtype()+' '+value.name())
  def print_about(self):
    print(self.attributes['_OBJTYPE'] + ' ' + self.attributes['NAME'])
    for key in self.attributes:
      print('  '+key+':')
  def from_text(self,fileName):
    pars = Parser()
    f = open(fileName)
    l = []
    for line in f:
      l.append(line)
    ll = pars.indent(l)
    self.from_list(ll[0])
  def from_list(self,l):
    expr = l[0].strip().split()
    num_tags = 0
    for word in expr[:-2]:
      if word[0] == '!':
        self.tags.append(word)
        num_tags += 1
    self.set('_OBJTYPE', expr[-2])
    name = expr[-1].strip(':')
    if self.parent != None:
      name = self.parent.name()+'.'+name
    print(name)
    namels = name.split('.')
    while 'super' in namels:
      ind = namels.index('super')
      namels = namels[:ind-1]+namels[ind+1:]
      print(namels)
    name = ''
    for word in namels:
      name += word + '.'
    name = name[:-1]
    if name in names:
      self = names[name]
    else:
      self.set('NAME',name)
      names[name] = self
    for expr in l[1:]:
      attr_name = expr[0].strip()
      attr_ls = []
      if attr_name[-1] == ':': # has additional blocks
        attr_name = attr_name.strip(':')
        if attr_name == 'DESCRIPTION':
          attr_ls = expr[1:]
        else:
          for sub_expr in expr[1:]:
            attr_val = PMLObject(self)
            attr_val = attr_val.from_list(sub_expr)
            attr_ls.append(attr_val)
      else:
        attr_ls.append(attr_name.split()[1])
        attr_name = attr_name.split()[0]
      self.set(attr_name, attr_ls)
    return self
      


class Parser:
  def get_indent(self,s):
    ret = 0
    while s[ret] == ' ': ret += 1
    return ret
  def indent(self,l):
    if len(l) == 0: return []
    indented = []
    ret = []
    initial_indent = self.get_indent(l[0])
    i = 0
    while i < len(l):
      if l[i].strip() == '':
        i += 1
        continue
      new_block = [l[i]]
      i += 1
      while i < len(l) and self.get_indent(l[i]) > initial_indent:
        if l[i].strip() == '':
          i += 1
          continue
        new_block.append(l[i])
        i += 1
      if len(new_block) > 1: indented.append(new_block)
      ret.append(new_block)
    for i in range(len(ret)):
      ret[i] = [ret[i][0]]+self.indent(ret[i][1:])
    return ret

  def print_indented(self,s, l):
    for x in l:
      if type(x) is str:
        print (s+x.strip())
      else:
        self.print_indented(s+'  ',x)


if __name__ == "__main__":
  f = open('pml_simple.pml')
  l = []
  for line in f:
    l.append(line)

  pars = Parser()
  lx = pars.indent(l)
  pars.print_indented('',lx)

  print(lx)

  n = PMLObject()
  n.from_list(lx[0])
  print(n.attributes)
  print(n.tags)

