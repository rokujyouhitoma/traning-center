EINVAL := 22;


_complain_ifclosed := method(closed,
  if(closed == true, Exception raise("I/O operation on closed file"), nil)
)

/**
 * StringIO is based on Python StringIO build-in modules.
 * @extends {Object}
 */
StringIO := Object clone do(

  /**
   * @param {?string} buf .
   * @return {StringIO}
   */
  clone := method(buf,
     self protos clone
     self init
     self buf := if(buf isNil, "", buf)
     self len := if(buf isNil, 0, buf size)
     self
  )

  /**
   * @return {StringIO}
   * @constructor
   */
  init := method(
    self buf := ""
    self len := 0
    self buflist := list()
    self pos := 0
    self closed := false clone
    self softspace := 0
    self
  )

  __iter__ := method(self)

  /**
   * @param {?number=} size .
   */
  next := method(
    _complain_ifclosed(self closed)
    r := self readline
    #TODO: if(r isEmpty, StopIteration raise(""))
    if(r isEmpty, Exception raise(""))
    r
  )

  /**
   * Free the memory buffer.
   */
  close := method(
    if(self closed not) then(
      self closed = true clone
      self removeSlot("buf")
      self removeSlot("pos")
    )
  )

  /**
   * Returns false because StringIO objects are not connected to a tty-like
   * device
   */
  isatty := method(
    _complain_ifclosed(self closed)
    return false
  )

  /**
   * Set the file's current position.
   * 
   * The mode argument is optional and defaults to 0 (absolute file
   * positioning); other values are 1 (seek relative to the current
   * position) and 2 (seek relative to the file's end).
   * There is no return value.
   */
  seek := method(pos, mode,
    if(mode isNil not, mode = 0)
    _complain_ifclosed(self closed)
    if(self buflist size > 0) then(
      self buf = self buf .. self buflist join
      self buflist = list()
    )
    if(mode == 1) then(
      pos = pos + self pos
    ) elseif(mode == 2) then(
      pos = pos + self len
    )
    self pos = list(0, pos) max
    nil
  )

  /**
   * Return the file's current position.
   */
  tell := method(pos, mode,
    if(mode isNil not, mode = 0)
    _complain_ifclosed(self closed)
    self pos
  )

  /**
   *
   */
  read := method(n,
    if(n isNil not, n = -1)
    _complain_ifclosed(self closed)
    if(self buflist size > 0) then(
      self buf = self buf .. self buflist join
      self buflist = list()
    )
    newpos := nil
    if(n isNil or n < 0) then(
      newpos = self len
    ) else(
      newpos = list(self pos + n, self len) min
    )
    r := self buf exSlice(self pos, newpos)
  )

  /**
   * @param {?number=} length .
   * @return {string} .
   */
  readline := method(length,
    _complain_ifclosed(self closed)
    if(self buflist size > 0) then(
      self buf = self buf .. self buflist join
      self buflist = list()
    )
    i := self buf findSeq("\n", self pos)
    if(i isNil, i = 0)
    newpos := nil
    if(i < 0) then(
      newpos = self len
    ) else (
      newpos = i + 1
    )
    if(length isNil not and length > 0) then(
      if(self pos + length < newpos) then(
        newpos = self pos + length
      )
    )
    r := self buf exSlice(self pos, newpos)
    self pos = newpos
    r
  )

  /**
   * @param {number} sizehint .
   */
  readlines := method(sizehint,
    if(sizehint isNil not, sizehint = 0)
    total := 0
    lines := list()
    line := self readline
    while(line isEmpty not,
      lines append(line)
      total = total + line size 
      if(0 < sizehint and sizehint <= total) then(
        break
      )
      line = self readline
    )
    lines
  )

  /**
   * @param {?number=} size .
   */
  truncate := method(size,
    _complain_ifclosed(self closed)
    if(size isNil) then(
      size = self pos
    ) elseif(size < 0) then(
      #TODO: IOError raise(EINVAL, 'Negative size not allowed')
      Exception raise("Negative size not allowed")
    ) elseif(size < self pos) then(
      self pos = size
    )
    self buf = self getvalue exSlice(0, size)
    self len = size
    nil
  )

  /**
   * @param {string} s .
   */
  write := method(s,
    _complain_ifclosed(self closed)
    if(s isEmpty, return nil)
    spos := self pos
    slen := self len
    if(spos == slen,
      self buflist append(s)
      self len = spos + s size
      self pos = spos + s size
      return nil
    )
    if(spos > slen,
      str := ""
      len := spos - slen
      for(i, 0, len -1, str = str .. "\0")
      self buflist append(str)
      slen = spos
    )
    newpos := spos + s size
    if(spos < slen,
      if(self buflist size > 0,
        self buf = self buf .. self buflist join)
        self buflist = list(self buf exSlice(0, spos), s, self buf exSlice(newpos, s size))
        self buf = ""
        if(newpos > slen, slen = newpos),
      self buflist append(s)
      slen = newpos
    )
    self len = slen
    self pos = newpos
    nil
  )

  /**
   * @param {Array} iterable .
   */
  writelines := method(iterable,
    iterable foreach(key, line, self write(line))
    nil
  )

  /**
   *
   */
  flush := method(
    _complain_ifclosed(self closed)
    nil
  )

  /**
   * @return {string} .
   */
  getvalue := method(
    if(self buflist isTrue,
      self buf := self buf .. self buflist join; self buflist := list()
    )
    self buf
  )
)
