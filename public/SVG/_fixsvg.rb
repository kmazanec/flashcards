class FixSvg
  
  def self.files_to_arr(search_path)
    Dir[search_path]
  end

  def self.replace(array)
    array.each do |file|
      content = File.read(file)
      content.sub!(/<g.+\/g>/, "" )
      content.sub!(/<!--.+-->/, "" )
      File.open(file, 'w') do |data|
        data << content
      end
    end
  end

end



files = FixSvg.files_to_arr("*.svg")

FixSvg.replace(files)


# p files
