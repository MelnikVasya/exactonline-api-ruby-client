# Fix bug when trying to call #dup method on symbol value
if Rails::VERSION::MAJOR <= 4
  module ThreadsafeAttributes
    private

    def get_threadsafe_attribute(name, main_thread = Thread.main)
      if threadsafe_attribute_defined_by_thread?(name, Thread.current)
        get_threadsafe_attribute_by_thread(name, Thread.current)
      elsif threadsafe_attribute_defined_by_thread?(name, main_thread)
        value = get_threadsafe_attribute_by_thread(name, main_thread)
        value = value.dup if value.duplicable?
        set_threadsafe_attribute_by_thread(name, value, Thread.current)
        value
      end
    end
  end
end
