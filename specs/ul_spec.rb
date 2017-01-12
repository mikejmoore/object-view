require_relative "./spec_helper"

include ObjectView

describe ObjectView::Ul do

  it "Can add line items" do
    ul = ObjectView::Ul.new
    item_1 = ul.item "Item 1"
    item_2 = ul.item "Item 2"
    html_doc =  Nokogiri::HTML::fragment(ul.render)

    expect(html_doc.xpath("ul/li").length).to eq 2
  end
  
  
end