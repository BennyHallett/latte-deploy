class LatteDeploy::EnvironmentState

  attr_reader :status, :text

  def self.unknown
    new('info', 'Unknown.')
  end

  def initialize(status, text)
    @status = status
    @text = text
  end

end
