class Color < ActiveHash::Base
  
  include ToHash

  self.data = [
    { id: 1, name: 'Aqua', hex_code: '#7fdbff' },
    { id: 18, name: 'Black', hex_code: '#111' },
    { id: 2, name: 'Blue', hex_code: '#0074d9' },
    { id: 12, name: 'Fuchsia', hex_code: '#f012be' },
    { id: 17, name: 'Gray', hex_code: '#aaa' },
    { id: 5, name: 'Green', hex_code: '#2ecc40' },
    { id: 7, name: 'Lime', hex_code: '#01ff70' },
    { id: 14, name: 'Maroon', hex_code: '#85144b' },
    { id: 3, name: 'Navy', hex_code: '#001f3f' },
    { id: 6, name: 'Olive', hex_code: '#3d9970' },
    { id: 9, name: 'Orange', hex_code: '#ff851b' },
    { id: 13, name: 'Purple', hex_code: '#b10dc9' },
    { id: 11, name: 'Red', hex_code: '#ff4136' },
    { id: 16, name: 'Silver', hex_code: '#ddd' },
    { id: 4, name: 'Teal', hex_code: '#39cccc' },
    { id: 15, name: 'White', hex_code: '#fff' },
    { id: 8, name: 'Yellow', hex_code: '#ffdc00' },
  ]
end
