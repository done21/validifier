require 'rubygems'
require 'hpricot'
require 'htmlentities'

module Validifier
  WIDTH = 425
  HEIGHT = 344
  CLASSID = "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
  CODEBASE = "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
  
  class FlashMovie
    attr_accessor :source, :width, :height, :params, :codebase, :classid, :comment
    
    def initialize(source, options={})
      @source = source
      @width  = options[:width] || WIDTH
      @height = options[:height] || HEIGHT
      @codebase = options[:codebase] || CLASSID
      @classid = options[:classid] || CODEBASE
      @params = options[:params] || {}
      @comment = options[:comment] || ""
      
      @coder = HTMLEntities.new
    end
    
    # nodoc
    def clean(str)
      @coder.encode(@coder.decode(str.to_s))
    end
    
    # The valid XHTML markup for this flash movie
    def to_s
      
      output = %Q{<!--[if !IE]> -->
  <object type="application/x-shockwave-flash" data="#{clean(source)}" width="#{clean(width)}" height="#{clean(height)}">
<!-- <![endif]-->
<!--[if IE]>
  <object classid="#{clean(classid)}" codebase="#{clean(codebase)}" width="#{clean(width)}" height="#{clean(height)}">
    <param name="movie" value="#{clean(source)}" />
<!--><!-- #{comment} -->
}
      params ||= {}
      params.each do |name, value|
       output << %Q{    <param name="#{clean(name)}" value="#{clean(value)}" />\n}
      end
      output + "  </object>\n<!-- <![endif]-->"
    end
    
    class <<self
      
      # Build a FlashMovie based on chunk of HTML (with object and/or embed code)
      def from_source(html_str)
        html = Hpricot(html_str)
        if object = (html/:object).first
          movie = scrape_object(object)
        elsif embed = (html/:embed).first
          movie = scrape_embed(embed)
        else
          return nil
        end
        movie
      end
      
      # Convert html to valid XHTML
      def validify(html_str)
        FlashMovie.from_source(html_str).to_s
      end
      
    private
      def scrape_object(object)
        movie_param = (object/"param[@name='movie']").first
        source = movie_param ? movie_param[:value] : object[:data]
        
        options = {}
        options[:width] = object[:width]
        options[:height] = object[:height]
        options[:classid] = object[:classid]
        options[:codebase] = object[:codebase]
        options[:params] = {}
        
        skip_params = %W(movie wmode)
        (object/:param).each do |param|
          next if skip_params.include?(param[:name].to_s)
          options[:params][param[:name]] = param[:value]
        end
        
        set_dimensions_from_style object[:style], options
        
        FlashMovie.new(source, options)
      end
      
      def scrape_embed(embed)
        source = embed[:src]
        
        options = {}
        options[:width] = embed[:width]
        options[:height] = embed[:height]
        options[:params] = {}
        
        skip_attrs = %W(wmode id src style movie)
        embed.attributes.each do |name, value|
          next if skip_attrs.include? name
          options[:params][name] = value 
        end
        
        set_dimensions_from_style embed[:style], options
        
        FlashMovie.new(source, options)
      end
      
      def set_dimensions_from_style style, options
        return unless style
        width = (/width\s*:\s*(\d+(em|ex|px|%|in|cm|pt|pc)|0)\s*;?/i).match(style)
        options[:width] = width[1] if width[1]
        
        height = (/height\s*:\s*(\d+(em|ex|px|%|in|cm|pt|pc)|0)\s*;?/i).match(style)
        options[:width] = height[1] if height[1]
        options
      end
    end
    
  end
end