module TableHelper

  def down_diff(diff)
    if diff >= 20
      -15
    elsif diff >= 10 && diff < 20
      -2
    elsif diff >= 5 && diff <= 9
      4
    elsif diff >= 0 && diff <= 4
      8
    else
      'error'
    end
  end
end
