class Tag < ActsAsTaggableOn::Tag
  class << self
    def extract(content)
      TermExtraction::Yahoo.new(
        :api_key => Credentials["yahoo.api"],
        :context => content
      ).terms
    end
  end
end