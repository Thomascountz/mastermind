class Code
  attr_reader :code_elements

  def code_elements
    %w(red blue yellow green purple orange)
  end

  def create_code
    code = []
    4.times { code << code_elements.sample }
    code
  end
end
