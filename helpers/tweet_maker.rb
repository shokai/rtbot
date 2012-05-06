# -*- coding: utf-8 -*-

class TweetMaker
  attr_reader :size
  def initialize(size=140)
    @size = size
  end

  def make(head, body, tail)
    rest = size - head.split(//u).size - tail.split(//u).size - 2
    if rest > body.split(//u).size
      return "#{head} #{body} #{tail}"
    else
      tmp = body.split(//u)[0...(rest-1)].join('')
      return "#{head} #{tmp}… #{tail}"
    end
  end
end


if __FILE__ == $0
  puts s = TweetMaker.new.make('RT .@shokai:',
                      '橋本 翔とは、アメリカ海軍にとって、平時に起きたものとしては最大の損失事故である。橋本 翔は、メキシコの歌手。伝統音楽とワールドミュージックのジャンルで活動している。',
                      'http://twitter.com/shokai')
  puts s.split(//u).size
  puts "--140 over--"
  puts s = TweetMaker.new.make('RT .@shokai:',
                      '橋本 翔とは、アメリカ海軍にとって、平時に起きたものとしては最大の損失事故である。橋本 翔は、メキシコの歌手。伝統音楽とワールドミュージックのジャンルで活動している。橋本 翔は、滋賀県長浜市木之本町飯浦を起点に同市木之本町大音交点に至る2.7kmの一般県道である。',
                      'http://twitter.com/shokai')
  puts s.split(//u).size
end







