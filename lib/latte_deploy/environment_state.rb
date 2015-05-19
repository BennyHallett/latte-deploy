class LatteDeploy::EnvironmentState

  attr_reader :status, :text

  @@failure_cases = %w{fail failed failure error bad}
  @@success_cases = %w{success ok successful good}

  def self.unknown
    new('info', 'Unknown.')
  end

  def initialize(status, text)
    if @@failure_cases.include? status
      @status = 'danger'
    elsif @@success_cases.include? status
      @status = 'success'
    end

    @status ||= status
    @text = text
  end

end
