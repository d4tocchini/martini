module ActsAsCategorizable
  class CategoryList < Array
    cattr_accessor :delimiter
    self.delimiter = ','

    attr_accessor :owner

    def initialize(*args)
      add(*args)
    end
    
    ##
    # Returns a new CategoryList using the given category string.
    #
    # Example:
    #   category_list = CategoryList.from("One , Two,  Three")
    #   category_list # ["One", "Two", "Three"]
    def self.from(string)
      glue   = delimiter.ends_with?(" ") ? delimiter : "#{delimiter} "
      string = string.join(glue) if string.respond_to?(:join)

      new.tap do |category_list|
        string = string.to_s.dup

        # Parse the quoted categories
        string.gsub!(/(\A|#{delimiter})\s*"(.*?)"\s*(#{delimiter}\s*|\z)/) { category_list << $2; $3 }
        string.gsub!(/(\A|#{delimiter})\s*'(.*?)'\s*(#{delimiter}\s*|\z)/) { category_list << $2; $3 }

        category_list.add(string.split(delimiter))
      end
    end

    ##
    # Add categories to the category_list. Duplicate or blank categories will be ignored.
    # Use the <tt>:parse</tt> option to add an unparsed category string.
    #
    # Example:
    #   category_list.add("Fun", "Happy")
    #   category_list.add("Fun, Happy", :parse => true)
    def add(*names)
      extract_and_apply_options!(names)
      concat(names)
      clean!
      self
    end

    ##
    # Remove specific categories from the category_list.
    # Use the <tt>:parse</tt> option to add an unparsed category string.
    #
    # Example:
    #   category_list.remove("Sad", "Lonely")
    #   category_list.remove("Sad, Lonely", :parse => true)
    def remove(*names)
      extract_and_apply_options!(names)
      delete_if { |name| names.include?(name) }
      self
    end

    ##
    # Transform the category_list into a category string suitable for edting in a form.
    # The categories are joined with <tt>CategoryList.delimiter</tt> and quoted if necessary.
    #
    # Example:
    #   category_list = CategoryList.new("Round", "Square,Cube")
    #   category_list.to_s # 'Round, "Square,Cube"'
    def to_s
      categories = frozen? ? self.dup : self
      categories.send(:clean!)

      categories.map do |name|
        name.include?(delimiter) ? "\"#{name}\"" : name
      end.join(delimiter.ends_with?(" ") ? delimiter : "#{delimiter} ")
    end

    private
  
    # Remove whitespace, duplicates, and blanks.
    def clean!
      reject!(&:blank?)
      map!(&:strip)
      uniq!
    end

    def extract_and_apply_options!(args)
      options = args.last.is_a?(Hash) ? args.pop : {}
      options.assert_valid_keys :parse

      if options[:parse]
        args.map! { |a| self.class.from(a) }
      end

      args.flatten!
    end
  end
end