module Formatting

  def red(text); colorize(text, 31); end
  def green(text); colorize(text, 32); end
  def yellow(text); colorize(text, 33); end
  def blue(text); colorize(text, 34); end
  def white(text); colorize(text, 37); end

  def display_heading(text)
    space(5)
    puts white(text)
    dash_length = text.length
    (1..dash_length).each {|dash| print dash == dash_length ? "-\n" : "-"}
  end

  def print_begin_main_process(message)
    space(3)
    puts yellow("~~~~~~ #{message} ~~~~~~")
    space(2)
  end

  def print_complete_main_process(message)
    space(1)
    puts green("~~~~~~ #{message} ~~~~~~")
    space(2)
  end

  def print_begin_sub_process(message)
    puts yellow("~ #{message}")
  end

  def print_complete_sub_process(message)
    puts green("✓ #{message}")
  end

  private

  def space(number)
    number.times { print "\n" }    
  end

  # def tilder(number)
  #   number.times {"~"}
  # end

  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end

end