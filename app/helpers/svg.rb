helpers do

  def icon(file)
    # exec('pwd')
    content = File.read("public/SVG/#{file}.svg")
  end

  def image(file)
    # exec('pwd')
    content = File.read("public/images/#{file}")
  end


end
