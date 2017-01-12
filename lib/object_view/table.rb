module ObjectView 

  class Table < Element 
    attr_reader   :tbody, :thead
    
    def initialize
      super()
      @tag = "table"
      self.acceptable_children = [TBody, THead]
    end

    def header_row(labels = nil)
      self.add @thead = THead.new
      row = THeadRow.new
      @thead.add row
      if (labels != nil)
        labels.each do |label|
          row.cell(label)
        end
      end
      return row
    end
  
    def row(cell_data = nil, cell_attributes = nil)
      if (@tbody == nil)
        self.add @tbody = TBody.new
      end
      row = @tbody.row
      if (cell_data != nil)
        cell_data.each do |element|
          cell = row.cell(element)
          if (cell_attributes != nil)
            cell_attributes.each do |name, value|
              cell.attr(name.to_s, value)
            end
          end
        end
      end
      return row
    end
  end

  class THead < Element
    def initialize
      super()
      self.single_line = true
      @tag = "thead"
      self.acceptable_children = [TRow]
    end
    
    def row
      @row = THeadRow.new
      self.add(@row)
      return @row
    end
  
  end

  class TBody < Element
    def initialize
      super()
      @tag = "tbody"
      self.acceptable_children = [TRow]
    end

    def row
      @row = TRow.new
      self.add(@row)
      return @row
    end
  end

  

  class TRow < Element
    def initialize
      super()
      @tag = "tr"
      self.acceptable_children = [TCell, THeadCell]
    end
  
    def cell(content = nil)
      cell = TCell.new
      if (content != nil)
        cell.add content
      end
      self.add cell
      return cell
    end
  end
  
  class THeadRow < TRow
    def initialize
      super()
      @tag = "tr"
      self.acceptable_children = [THeadCell]
    end

    def cell(content = nil)
      cell = THeadCell.new
      if (content != nil)
        cell.add content
      end
      self.add cell
      return cell
    end
  end


  class TCell < Element
    def initialize
      super()
      self.single_line = true
      @tag = "td"
      self.acceptable_children = [Table, Div, Span, Javascript, Link, String]
    end
  end
  
  
  class THeadCell < TCell
    def initialize
      super()
      self.single_line = true
      @tag = "th"
    end
  end
  
end