# コンソール起動時
if defined? Rails::Console
# Hirb.enableの有効性
  if defined? Hirb
    # hirbをオン
    Hirb.enable
    # hirbをオフ
    # Hirb.disable
  end

end
