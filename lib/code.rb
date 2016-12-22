class Code
  attr_reader :code_elements, :code

  def initialize 
    @code_elements = %w(red blue yellow green purple orange)
    @code = create_code
  end
  
  def create_code
    code = []
    4.times { code << @code_elements.sample }
    code
  end

end
