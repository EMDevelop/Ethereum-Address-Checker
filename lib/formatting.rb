module Formatting

  def red(text); colorize(text, 31); end
  def green(text); colorize(text, 32); end
  def yellow(text); colorize(text, 33); end
  def blue(text); colorize(text, 34); end
  def white(text); colorize(text, 37); end

  def display_heading(text)
    5.times { print "\n" }
    puts white(text)
    dash_length = text.length
    (1..dash_length).each {|dash| print dash == dash_length ? "-\n" : "-"}
  end

  private

  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

end