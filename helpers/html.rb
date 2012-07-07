class String
  def markup_html
    self.gsub(/(https?:\/\/[^\s]+)/){"<a href=\"#{$1}\">#{$1}</a>" }
  end
end

if __FILE__ == $0
  puts s = "hello this site is cool http://shokai.org thx."
  puts s.markup_html
end
