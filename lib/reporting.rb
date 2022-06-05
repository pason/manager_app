class Reporting
  def self.log(error, tags = {})
    log_msg = error.to_s

    if tags
      tags_str = tags.map { |k, v| "#{k}=#{v}" }.join(', ')
      log_msg += ", #{tags_str}"
    end

    if error.is_a? String
      Rails.logger.error "#{log_msg}\n#{Kernel.caller.join("\n")}"
    else
      Rails.logger.error "#{log_msg}\n#{error.stack_trace}"
    end
  end
end