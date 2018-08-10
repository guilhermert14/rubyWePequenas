Dado(/^que acesso o site$/) do

  $EL = "EL_#{$site}"
  local = DATA["local"]
  local = local.gsub('bandeira', $site)
  visit(local)
  
end
