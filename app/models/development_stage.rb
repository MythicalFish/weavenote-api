class DevelopmentStage < ActiveHash::Base
  
  include ToHash
  
  self.data = [
    { id: 1, label: 'Sample' },
    { id: 2, label: 'Production' },
    { id: 3, label: 'Done' },
  ]
end
