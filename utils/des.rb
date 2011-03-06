module RDCL

  #key =  0b1000111111111011001111011101100110011110111010100010110011001000
  #data = 0b1111011110110011110101011001000111100110101000101100010010000000

  #key = 0x3b3898371520f75e
  #data = 0x0123456789abcdef

  #key  = 0x4cc7618a9849c4e6
  #data = 0x0000000000000000

  class DES

    DEFAULT_KEY = 0x4cc7618a9849c4e6
    NEWTON_DEFAULT_KEY = 0x57406860626D7464

    PC1 = [
      57,  49,   41,  33,   25,   17,   9,
       1,  58,   50,  42,   34,   26,  18,
      10,   2,   59,  51,   43,   35,  27,
      19,  11,    3,  60,   52,   44,  36,
      63,  55,   47,  39,   31,   23,  15,
       7,  62,   54,  46,   38,   30,  22,
      14,   6,   61,  53,   45,   37,  29,
      21,  13,    5,  28,   20,   12,   4
    ]

    PC2 = [
      14,    17,   11,    24,     1,    5,
       3,    28,   15,     6,    21,   10,
      23,    19,   12,     4,    26,    8,
      16,     7,   27,    20,    13,    2,
      41,    52,   31,    37,    47,   55,
      30,    40,   51,    45,    33,   48,
      44,    49,   39,    56,    34,   53,
      46,    42,   50,    36,    29,   32
    ]

    IP = [
      58, 50, 42, 34, 26, 18, 10,  2,
      60, 52, 44, 36, 28, 20, 12,  4,
      62, 54, 46, 38, 30, 22, 14,  6,
      64, 56, 48, 40, 32, 24, 16,  8,
      57, 49, 41, 33, 25, 17,  9,  1,
      59, 51, 43, 35, 27, 19, 11,  3,
      61, 53, 45, 37, 29, 21, 13,  5,
      63, 55, 47, 39, 31, 23, 15,  7
    ]

    E = [
      32,  1,  2,  3,  4,  5,
       4,  5,  6,  7,  8,  9,
       8,  9, 10, 11, 12, 13,
      12, 13, 14, 15, 16, 17,
      16, 17, 18, 19, 20, 21,
      20, 21, 22, 23, 24, 25,
      24, 25, 26, 27, 28, 29,
      28, 29, 30, 31, 32,  1
    ]

    SHIFTS = [1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1]

    S = [
      [
        [14,  4,  13,  1,   2, 15,  11,  8,   3, 10,   6, 12,   5,  9,   0,  7],
        [ 0, 15,   7,  4,  14,  2,  13,  1,  10,  6,  12, 11,   9,  5,   3,  8],
        [ 4,  1,  14,  8,  13,  6,   2, 11,  15, 12,   9,  7,   3, 10,   5,  0],
        [15, 12,   8,  2,   4,  9,   1,  7,   5, 11,   3, 14,  10,  0,   6, 13]
      ],

      [
        [15,  1,   8, 14,   6, 11,   3,  4,   9,  7,   2, 13,  12,  0,   5, 10],
        [ 3, 13,   4,  7,  15,  2,   8, 14,  12,  0,   1, 10,   6,  9,  11,  5],
        [ 0, 14,   7, 11,  10,  4,  13,  1,   5,  8,  12,  6,   9,  3,   2, 15],
        [13,  8,  10,  1,   3, 15,   4,  2,  11,  6,   7, 12,   0,  5,  14,  9]
      ],

      [
        [10,  0,   9, 14,   6,  3,  15,  5,   1, 13,  12,  7,  11,  4,   2,  8],
        [13,  7,   0,  9,   3,  4,   6, 10,   2,  8,   5, 14,  12, 11,  15,  1],
        [13,  6,   4,  9,   8, 15,   3,  0,  11,  1,   2, 12,   5, 10,  14,  7],
        [ 1, 10,  13,  0,   6,  9,   8,  7,   4, 15,  14,  3,  11,  5,   2, 12]
      ],

      [
        [ 7, 13,  14,  3,   0,  6,   9, 10,   1,  2,   8,  5,  11, 12,   4, 15],
        [13,  8,  11,  5,   6, 15,   0,  3,   4,  7,   2, 12,   1, 10,  14,  9],
        [10,  6,   9,  0,  12, 11,   7, 13,  15,  1,   3, 14,   5,  2,   8,  4],
        [ 3, 15,   0,  6,  10,  1,  13,  8,   9,  4,   5, 11,  12,  7,   2, 14]
      ],

      [
        [ 2, 12,   4,  1,   7, 10,  11,  6,   8,  5,   3, 15,  13,  0,  14,  9],
        [14, 11,   2, 12,   4,  7,  13,  1,   5,  0,  15, 10,   3,  9,   8,  6],
        [ 4,  2,   1, 11,  10, 13,   7,  8,  15,  9,  12,  5,   6,  3,   0, 14],
        [11,  8,  12,  7,   1, 14,   2, 13,   6, 15,   0,  9,  10,  4,   5,  3]
      ],

      [
        [12,  1,  10, 15,   9,  2,   6,  8,   0, 13,   3,  4,  14,  7,   5, 11],
        [10, 15,   4,  2,   7, 12,   9,  5,   6,  1,  13, 14,   0, 11,   3,  8],
        [ 9, 14,  15,  5,   2,  8,  12,  3,   7,  0,   4, 10,   1, 13,  11,  6],
        [ 4,  3,   2, 12,   9,  5,  15, 10,  11, 14,   1,  7,   6,  0,   8, 13]
      ],

      [
        [ 4, 11,   2, 14,  15,  0,   8, 13,   3, 12,   9,  7,   5, 10,   6,  1],
        [13,  0,  11,  7,   4,  9,   1, 10,  14,  3,   5, 12,   2, 15,   8,  6],
        [ 1,  4,  11, 13,  12,  3,   7, 14,  10, 15,   6,  8,   0,  5,   9,  2],
        [ 6, 11,  13,  8,   1,  4,  10,  7,   9,  5,   0, 15,  14,  2,   3, 12]
      ],

      [
        [13,  2,   8,  4,   6, 15,  11,  1,  10,  9,   3, 14,   5,  0,  12,  7],
        [ 1, 15,  13,  8,  10,  3,   7,  4,  12,  5,   6, 11,   0, 14,   9,  2],
        [ 7, 11,   4,  1,   9, 12,  14,  2,   0,  6,  10, 13,  15,  3,   5,  8],
        [ 2,  1,  14,  7,   4, 10,   8, 13,  15, 12,   9,  0,   3,  5,   6, 11]
      ],
    ]

    P = [
      16,   7,  20,  21,
      29,  12,  28,  17,
       1,  15,  23,  26,
       5,  18,  31,  10,
       2,   8,  24,  14,
      32,  27,   3,   9,
      19,  13,  30,   6,
      22,  11,   4,  25
    ]

    IPinv = [
      40,     8,   48,    16,    56,   24,    64,   32,
      39,     7,   47,    15,    55,   23,    63,   31,
      38,     6,   46,    14,    54,   22,    62,   30,
      37,     5,   45,    13,    53,   21,    61,   29,
      36,     4,   44,    12,    52,   20,    60,   28,
      35,     3,   43,    11,    51,   19,    59,   27,
      34,     2,   42,    10,    50,   18,    58,   26,
      33,     1,   41,     9,    49,   17,    57,   25
    ]
    
    attr_accessor :k

    def initialize
    end

    def set_key(key)
      key_flipped = 0
      (0..63).each do |i|
        key_flipped = key_flipped | (key[i] << (63 - i))
      end
      
      # Permutate key ==================

      permutated_key = Array.new(56, 0)

      (0..55).each do |i|
        permutated_key[i] = key_flipped[PC1[i] - 1]
      end

      # puts "Perm. key = #{bits_to_s(permutated_key, 7)}"
      # printf "Perm. key = %x / %x (f)\n", to_bin(permutated_key), to_bin(permutated_key, true)
      # puts

      # Create C and D -----------------

      c = Array.new(17)
      d = Array.new(17)

      c[0] = permutated_key[0..27]
      d[0] = permutated_key[28..55]

      #puts "C[0] = #{bits_to_s(c[0], 7)}"
      #puts "D[0] = #{bits_to_s(d[0], 7)}"
      #puts "CD[0] = #{bits_to_s(c[0] + d[0], 8)}"

      (1..16).each do |i|
        c[i] = Array.new(c[i - 1])
        d[i] = Array.new(d[i - 1])

        (1.. SHIFTS[i - 1]).each do |s|
          c0 = c[i][0]
          d0 = d[i][0]
          (0..26).each do |j|
            c[i][j] = c[i][j + 1]
            d[i][j] = d[i][j + 1]
          end
          c[i][27] = c0
          d[i][27] = d0
        end

      #  puts "C[#{i}] = #{bits_to_s(C[i], 7)}"
      #  puts "D[#{i}] = #{bits_to_s(D[i], 7)}"
      end

      # Create K ------------------------

      @k = Array.new(16)
      (0..15).each do |i|
        k_temp = c[i + 1] + d[i + 1]; # puts "k = #{bits_to_s(@k, 7)}"
        @k[i] = Array.new(48, 0)
        (0..47).each do |j|
          @k[i][j] = k_temp[PC2[j] - 1]
        end
        # puts "K[#{i}] = #{bits_to_s(@k[i], 6)}"
      end
    end

    def set_newton_key(key)
      low =  key & 0x00000000ffffffff
      high = (key & 0xffffffff00000000) >> 32
      
      low <<= 1
      high <<= 1
      set_key((high << 32) + low)
      
      data = 0
      tmp_key = encrypt_block(data)

      key = tmp_key | fix_parity(tmp_key, true)


      low =  key & 0x00000000ffffffff
      high = (key & 0xffffffff00000000) >> 32
      
      low <<= 1
      high <<= 1
      set_key((high << 32) + low)
    end
    
    def fix_parity(data, even)
      (0...data.size).each do |i|
        n = 0
        (1..7).each do |j|
          n += data[i * 8 + j]
        end
        if n % 2 == (even ? 0 : 1)
          data |= (1 << (i * 8))
        else
          data &= ~(1 << (i * 8))
        end
      end
      return data
    end
  
    def encrypt_block(block)
      return process_block(block, true)
    end
  
    def decrypt_block(block)
      return process_block(block, false)
    end

    def process_block(data, encrypt)
      data_flipped = 0
      (0..63).each do |i|
        data_flipped = data_flipped | (data[i] << (63 - i))
      end

      # Initial permutation ===============

      permutated_data = Array.new(64, 0)
      (0..63).each do |i|
        permutated_data[i] = data_flipped[IP[i] - 1]
      end

      l = Array.new(17)
      r = Array.new(17)
      b = Array.new(8)

      l[0] = permutated_data[0..31]
      r[0] = permutated_data[32..63]

      # 16 rounds of S boxes ==============

      (1..16).each do |i|
        l[i] = Array.new(r[i - 1])
        r[i] = Array.new(l[i - 1])

        e = Array.new(48, 0)
        (0..47).each do |j|
          if encrypt
            e[j] = r[i - 1][E[j] - 1] ^ @k[i - 1][j]
          else
            e[j] = r[i - 1][E[j] - 1] ^ @k[15 - (i - 1)][j]
          end
        end

        s = Array.new(32, 0)
        (0..7).each do |j|
          b[j] = e[(j * 6)..(j * 6) + 5]
          b_y = (b[j][0] << 1) + b[j][5]
          b_x = (b[j][1] << 3) + (b[j][2] << 2) + (b[j][3] << 1) + b[j][4]
          s_sub = S[j][b_y][b_x]
          (0..3).each do |h|
            s[j * 4 + h] = s_sub[3 - h]
          end
        end

        f = Array.new(32, 0)
        (0..31).each do |j|
          f[j] = s[P[j] - 1]
        end

        (0..31).each do |j|
          r[i][j] = f[j] ^ l[i - 1][j]
        end
      end

      final = r[16] + l[16]
      output = Array.new(64, 0)
      output_bin = 0
      (0..63).each do |i|
        output[i] = final[IPinv[i] - 1]
        output_bin = output_bin | (output[i] << (i))
      end

      output_bin_flipped = 0
      (0..63).each do |i|
        output_bin_flipped = output_bin_flipped | (output_bin[i] << (63 - i))
      end

      return output_bin_flipped
    end

    def bits_to_s(bits, mod)
      r = ""
      (0..bits.length - 1).each do |i|
        r += (bits[i] + 48).chr
        r += 32.chr if (i + 1) % mod == 0
      end
      return r
    end
    
    def to_bin(bits, flip = false)
      output_bin = 0
      (0...bits.length).each do |j|
        if flip
          output_bin = output_bin | (bits[j] << (bits.length - 1 - j))
        else
          output_bin = output_bin | (bits[j] << (j))
        end
      end
      return output_bin
    end

  end

end

if $0 == __FILE__
#  key =  RDCL::DES::DEFAULT_KEY
#  data = 0x74d7e2efec7e23d1
  key =  RDCL::DES::NEWTON_DEFAULT_KEY
  data = 0x000f1f6bff82ddcb

  printf "key = %x\n", key
  printf "dat = %x\n", data

  c = RDCL::DES.new
  c.set_newton_key(key)
  encr = c.encrypt_block(data)

  printf "enc = %x\n", encr

  decr = c.decrypt_block(encr)

  printf "dec = %x\n", decr
end
