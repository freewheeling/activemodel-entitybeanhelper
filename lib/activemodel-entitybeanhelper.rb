require 'java'
require 'rubygems'
require 'active_model'

module ActiveModel::EntityBeanHelper

  #This constructor is called when the JBeanHelper module is extended by a super
  #class (i.e. a JRuby bean/activemodel class) to create a mixin. This constructor
  #will register the ActiveModel elements from the reflected JBean annotations on
  #the native java class
  
  def self.extended(base)
 
    #Abort with friendly message if attempt to extend non-Java native class
    unless base.respond_to? 'java_class'
      puts "Warning: Attempt to use JBeanHelper with non-native Java class or superclass"
      return
    end
    
    #Add class var to hold list of java props (to reduce cost of reflection later)
    base.send(:class_variable_set,:@@prop_methods, Array.new)
 
    #Add the necessary includes for the base class to behave as an ActiveModel record
    base.send  :include,ActiveModel::Validations
    base.send  :include,ActiveModel::Conversion
    base.send  :extend,ActiveModel::Naming
 
    #Fetch native Java class   
    jclass = base.java_class
    
    #Using reflection, check for property methods, and their annotations
    #If annotation is an EJB property validation annotation with an ActiveModel equivalent,
    #then call the appropriate ActiveModel validate method to register it
    jclass.declared_instance_methods.each do |java_method|
      java_method_name = java_method.name
      if java_method_name[0,3] = 'set'
        ruby_property_name = java_method_name[3..-1].camelize(:lower)
        base.send(:class_variable_get, :@@prop_methods).push ruby_property_name
        java_method.annotations.each do |annotation|
          #TODO - javax.validation.constraints.NotNull => validates_presence_of 
          #TODO - validates_length_of
          #TODO - validates_numericality_of
          #TODO - javax.validation.constraints.Pattern => validates_format_of
          #TODO - etc.
          if annotation.annotation_type.canonical_name.eql? 'javax.validation.constraints.NotNull'
            base.send :validates_presence_of, ruby_property_name
          end        
        end
      end
    end
    
    #Add the initializer method for the extended class
    base.send(:define_method, :initialize) do |*args|
      super()
      if args.size == 1 and args[0].is_a? Java::JavaLang::Object 
        #Initialize from property values in existing JavaBean passed to 'new' constructor
        base.send(:class_variable_get, :@@prop_methods).each do |prop_method|
          send("#{prop_method}=", args[0].send("#{prop_method}")) 
        end
        
      else   
        #Initialize from attribute list passed as parameter to 'new' constructor
        args.each do |name, value|
          send("#{name}=", value)
        end 
      end  
    end
    
    #Add other ActiveModel required/expected methods
    base.send(:define_method, :persisted?) do 
      false
    end
    
  end

end



    