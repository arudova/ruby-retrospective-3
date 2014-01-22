module Asm
	attr_accessor :registers, :cmp, :instructions_to_be_executed
	attr_accessor :ax, :bx, :cx, :dx, :all_functions

	def self.asm(&block)
		p self.class
		block.call
		#@registers.values
	end

	def mov(destination_register, source)
		@registers = Hash.new if @registers == nil
		p destination_register.to_proc.call
		p source
		if source.class == Fixnum
			@registers[destination_register.to_proc.call] = source
		else
			@registers[destination_register.to_proc.call] = @registers[source]
		end
		p @registers
	end

	def inc(destination_register, value)
		if value.class == Fixnum
			@registers[destination_register] += value
		else
			@registers[destination_register] += @registers[value]
		end
	end

	def dec(destination_register, value = -1)
		if value.class == Fixnum
			@registers[destination_register] -= value
		else
			@registers[destination_register] -= @registers[value]
		end
	end

	def cmp(register, value)
		if value.class == Fixnum
			@cmp = (@registers[destination_register] <=> value)
		else
			@cmp = (@registers[destination_register] <=> @registers[value])
		end
	end

	def label(label_name)
	end

	def jmp(where)
	end

	def je(where)
	end

	def jne(where)
	end

	def jl(where)
	end

	def jle(where)
	end

	def jg(where)
	end

	def jge(where)
	end

	def create_result(operation, number)
		new_result = []
		@result.each_with_index do |item, index|
			@your_number = @your_numbers[index]
			item = item.send operation, number if number.class == Fixnum
			item = item.send operation, @your_number if number.class == Symbol
			new_result << item
		end
		@result = new_result
	end

	def method_missing(method_id)
		:method_id
	end

	def construct_all_functions(&block)
	end

end