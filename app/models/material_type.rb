class MaterialType < ActiveHash::Base
  
  include ToHash

  self.data = [
    { id: 12, name: 'Button' },
    { id: 8, name: 'Canvas' },
    { id: 1, name: 'Fabric' },
    { id: 5, name: 'Fur' },
    { id: 7, name: 'Fusing' },
    { id: 2, name: 'Leather' },
    { id: 6, name: 'Lining' },
    { id: 9, name: 'Trim' },
    { id: 3, name: 'Knit' },
    { id: 10, name: 'Wadding' },
    { id: 4, name: 'Yarn' },
    { id: 11, name: 'Zip' },
  ]
end
