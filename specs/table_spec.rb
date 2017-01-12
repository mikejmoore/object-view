require_relative "./spec_helper"

include ObjectView

describe ObjectView::Table do

  it "Can add rows and cells" do
    table = ObjectView::Table.new
    table.row ["Cell 1", "Cell 2", "Cell 3"]
    html_doc =  Nokogiri::HTML::fragment(table.render)
    
    expect(html_doc.xpath('table').length).to eq 1
    expect(html_doc.xpath('table/tbody/tr').length).to eq 1
    expect(html_doc.xpath('table/tbody/tr/td').length).to eq 3
  end
  
  it "Can add header rows" do
    table = ObjectView::Table.new
    table.header_row ["Head 1", "Head 2", "Head 3"]
    table.row ["Cell 1", "Cell 2", "Cell 3"]
    html_doc =  Nokogiri::HTML::fragment(table.render)
    
    expect(html_doc.xpath('table').length).to eq 1
    expect(html_doc.xpath('table/thead/tr').length).to eq 1
    expect(html_doc.xpath('table/thead/tr/th').length).to eq 3
    expect(html_doc.xpath('table/tbody/tr').length).to eq 1
    expect(html_doc.xpath('table/tbody/tr/td').length).to eq 3
  end

  it "Rows can be built from various elements" do
    table = ObjectView::Table.new
    table.row([Span.new("Cell 1"), Div.new("Cell 2"), "Cell 3"])
    html_doc =  Nokogiri::HTML::fragment(table.render)
    expect(html_doc.xpath('table/tbody/tr/td/span').length).to eq 1
    expect(html_doc.xpath('table/tbody/tr/td/div').length).to eq 1
    expect(html_doc.xpath('table/tbody/tr/td').length).to eq 3
  end
  
  it "Cannot add divs directly to table" do
    table = ObjectView::Table.new
    expect {
      table.add ObjectView::Div.new
    }.to raise_error(ObjectView::IllegalChildElementError)
  end
  
end