#
# Sinister.
#-----------------------------
#
# Syntax sinistr project_name generate|remove [all|[views css:stylesheet javascript:js i18n:i18n images:img]]
#
#
#
class SiniStrParameter
  
	attr_reader :type, :value
	
	###
	#
	###
	def initialize(str)
		@type, @value = str.strip().split(':')
		raise Exception.new("Parameter not valid.") if (!@type)
		@value = @type if (!@value)		
	end
	
	###
	#
	###
	def to_s()
	  "Class name : SiniStrParameter | values --> type : '#{@type}', value : '#{@value}'."
	end
	
end

require 'fileutils'

class Sinistr
  
	GENERATE_OPERATION = 'generate'
	REMOVE_OPERATION   = 'remove'

	###
	#
	###
	def self.do_process(args)
	  
	  parameters = Array.new()

	  # Project name (first parameter)	  
	  project_name = args.shift()	  
	  
	  # Operation (second parameter)
	  operation = args.shift() 
	  if (operation != GENERATE_OPERATION && operation != REMOVE_OPERATION)
		raise Exception.new("Unknown operation #{operation}") 
	  end
	  
	  # What do we want to do (rest of parameters)
	  if (args[0] == 'all')
		parameters << SiniStrParameter.new('css')
		parameters << SiniStrParameter.new('javascript')
		parameters << SiniStrParameter.new('i18n')
		parameters << SiniStrParameter.new('images')
		parameters << SiniStrParameter.new('views')
	  else
		args.each do |arg|
		  parameters << SiniStrParameter.new(arg)
		end
	  end
	  
	  # Operation (first parameter)
	  case operation 
		when GENERATE_OPERATION
		  puts 'Generating Sinatra structure...'		  
		  generate(project_name, parameters)
		  puts '...done'

		when REMOVE_OPERATION
		  puts 'Removing Sinatra structure...'		  		  
		  remove(project_name, parameters)
		  puts '...done'
	  else
		  raise Exception.new("Unknown operation #{operation}")
		  exit 1
	  end	  
	  
	end

	###
	#
	###
	def self.generate(project_name, parameters)
		parameters.each do |param|
		  create_path(project_name + '/' + param.value)	  		if (param.type == 'views' && create?(project_name + '/' + param.value))
		  create_path(project_name + '/' + param.value) 		if (param.type == 'i18n' && create?(project_name + '/' + param.value))
		  create_path(project_name + '/public/' + param.value) if (param.type == 'css' && create?(project_name + '/public/' + param.value))
		  create_path(project_name + '/public/' + param.value) if (param.type == 'images' && create?(project_name + '/public/' + param.value))
		  create_path(project_name + '/public/' + param.value) if (param.type == 'javascript' && create?(project_name + '/public/' + param.value))
		end
	end
	
	###
	#
	###	
	def self.remove(project_name, parameters)
		parameters.each do |param|
		  remove_path(project_name + '/' + param.value) 		if (param.type == 'i18n' && remove?(project_name + '/' + param.value))
		  remove_path(project_name + '/public/' + param.value) 	if (param.type == 'css' && remove?(project_name + '/public/' + param.value))
		  remove_path(project_name + '/public/' + param.value) 	if (param.type == 'images' && remove?(project_name + '/public/' + param.value))
		  remove_path(project_name + '/public/' + param.value) 	if (param.type == 'javascript' && remove?(project_name + '/public/' + param.value))
		  remove_path(project_name + param.value) 				if (param.type == 'views' && remove?(project_name + '/' + param.value))
		end		
		remove_path(project_name + '/public') 	if (remove?(project_name + '/public'))
		remove_path(project_name) 				if (remove?(project_name))		
		                                                           
	end
		                                      
	private

	###
	#
	###	
	def self.create_path(path)
	  print("\tCreating #{path}...")
	  FileUtils.mkpath(path)
	  puts('done.')
	end		
	
	###
	#
	###	
	def self.remove_path(path)
	  print("\tRemoving #{path}...")
	  Dir.rmdir(path)
	  puts('done.')
	end	
	
	###
	#
	###	
	def self.create?(path)
	  return !File.exist?(path) || (File::exist?(path) && !File::directory?(path))
	end

	###
	#
	###	
	def self.remove?(path)
	  return File::exist?(path) && File::directory?(path) && !(Dir.entries(path).size > 2)
	end

end
