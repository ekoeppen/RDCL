class String
  
  def to_utf16_be
    v = ""
    self.each_byte do |b|
      v += [b].pack("n")
    end
    return v
  end
  
  def String.from_utf16be(s)
    r = ""
    (0 ... s.length / 2).each do |i|
      break if s[i * 2 + 1] == 0
      r += s[i * 2 + 1].chr
    end
    return r
  end
  
end
