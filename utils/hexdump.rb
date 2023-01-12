# ==============================================================================
# EXTENDING CLASS STRING
# ==============================================================================
#
# (C) Copyright 2004 by Tilo Sloboda <tools@unixgods.org>
#
# License:
#         Freely available under the terms of the OpenSource "Artistic License"
#         in combination with the Addendum A (below)
#
#         In case you did not get a copy of the license along with the software,
#         it is also available at:   http://www.unixgods.org/~tilo/artistic-license.html
#
# Addendum A:
#         THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU!
#         SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
#         REPAIR OR CORRECTION.
#
#         IN NO EVENT WILL THE COPYRIGHT HOLDERS  BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL,
#         SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY
#         TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED
#         INACCURATE OR USELESS OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM
#         TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF THE COPYRIGHT HOLDERS OR OTHER PARTY HAS BEEN
#         ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.


class String
  #
  # prints out a good'ol hexdump of the data contained in the string
  #
  # parameters:     sparse:   true / false     do we want to print multiple lines with zero values?

  def hexdump(sparse = false)
    selfsize = self.size
    first = true
    out = "             0 1 2 3  4 5 6 7  8 9 A B  C D E F\n"

    lines,rest = selfsize.divmod(16)
    address = 0; i = 0    # we count them independently for future extension.

    while lines > 0
      str = self[i..i+15]

      # we don't print lines with all zeroes, unless it's the last line

      if str == "\0"*16     # if the 16 bytes are all zero

        if (!sparse) || (sparse &&  lines == 1 && rest == 0)
          out += sprintf( "%08x    %s %8s %8s %8s    %s\n", 
            address, self[i..i+3].unpack('H8')[0], self[i+4..i+7].unpack('H8')[0],
            self[i+8..i+11].unpack('H8')[0], self[i+12..i+15].unpack('H8')[0], str.gsub(/[^[:print:]]/,'.'))
        else
          out += "  ....      00 .. 00 00 .. 00 00 .. 00 00 .. 00    ................\n" if first
          first = false
        end

        else  # print string which is not all zeros

          out += sprintf( "%08x    %8s %8s %8s %8s    %s\n", 
            address, self[i..i+3].unpack('H8')[0], self[i+4..i+7].unpack('H8')[0],
            self[i+8..i+11].unpack('H8')[0], self[i+12..i+15].unpack('H8')[0], str.gsub(/[^[:print:]]/,'.'))
          first = true
        end
        i += 16; address += 16; lines -= 1
      end

      # now do the remaining bytes, which don't fit a full line..
      # yikes - this is truly ugly!  REWRITE THIS!!

      if rest > 0
        chunks2,rest2 = rest.divmod(4)     
        j = i; k = 0
        if (i < selfsize)
        out += sprintf( "%08x    ", address)
        while (i < selfsize)
          out += sprintf "%02x", self[i..i].unpack("C")[0]
          i += 1; k += 1
          out += " " if ((i % 4) == 0)
        end
        for i in (k..15)
          out += "  "
        end
        str = self[j..selfsize]
        out += " " * (4 - chunks2+1)
        out += sprintf("  %s\n", str.gsub(/[^[:print:]]/,'.'))
      end
    end
    
    return out
  end

end



if __FILE__ == $0

  s =  "some random long string"

  t =  s << "\0"*40  << s << "\0"*32 << s << "bla bla bla!"
  puts t.hexdump(true)
  puts t.hexdump(false)

  4.times {t.chop!}

  puts t.hexdump(true)
  puts t.hexdump(false)

end
