require_relative "./spec_helper"

include ObjectView

describe ObjectView::Div do

  it "Can set css class of div" do
    div = ObjectView::Div.new
    div.css_class = ".my_div"
    html_doc =  Nokogiri::HTML::fragment(div.render)

    div_element = html_doc.xpath("div").first
    expect(div_element.attr('class')).to eq '.my_div'
  end


  it "Can set style of div" do
    div = ObjectView::Div.new
    div.style = {border: '1px solid black', margin_right: '30px'}
    html_doc =  Nokogiri::HTML::fragment(div.render)

    div_element = html_doc.xpath("div").first
    expect(div_element.attr('style')).to eq "border: 1px solid black; margin-right: 30px"
  end
  
end