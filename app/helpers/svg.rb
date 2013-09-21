helpers do

  def icon(file)
    # exec('pwd')
    content = File.read("public/SVG/#{file}.svg")
  end


end
