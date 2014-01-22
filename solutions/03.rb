module Graphics
	class Canvas
		attr_reader :width
		attr_reader :height
		#attr_reader :filled
		attr_reader :canvas

		def initialize(width, height)
			@width = width
			@height = height
			@canvas = []
			while height > 0 do
				@canvas << Array.new(width, "-")
				height = height - 1
			end
		end

		def set_pixel(x, y)
			@canvas[y][x] = "@"
		end

		def pixel_at?(x, y)
			@canvas[y][x] == "@"
		end

		def draw
		end

		def render_as
		end

	end
end