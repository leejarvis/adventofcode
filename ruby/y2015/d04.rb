require "digest/md5"

def find_hash(input, prefix, i: 0)
  loop do
    hash = Digest::MD5.hexdigest("#{input}#{i}")
    return i if hash.start_with?(prefix)
    i += 1
  end
end

input = "yzbqklnj"
p1 = find_hash(input, "00000")
p2 = find_hash(input, "000000", i: p1)

p [p1, p2]
