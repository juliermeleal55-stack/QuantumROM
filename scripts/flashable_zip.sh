# ── Generate updater-script ───────────────────────────────────────────────────
log "Generating updater-script..."
mkdir -p "$STAGING/META-INF/com/google/android"
SCRIPT_FILE="$STAGING/META-INF/com/google/android/updater-script"

# Prevenção: Força a criação do arquivo limpo (se já existir, será sobrescrito/zerado)
> "$SCRIPT_FILE"

# Preenche o updater-script
cat > "$SCRIPT_FILE" << EOF
ui_print(" ");
ui_print("****************************************************");
ui_print("Welcome to QuantumROM ${ROM_CODENAME} v${ROM_VERSION}!");
ui_print("Initial QuantumROM build system coded by Abdullah Al Noman");
ui_print("Special thanks to all QuantumROM Maintainers, Contribuitors and Testers");
ui_print("****************************************************");
ui_print("One UI version: 8.5");
ui_print("****************************************************");
ui_print("After installation, it is highly recommended to FORMAT DATA as follows:");
ui_print("     Wipe -> Format Data");
ui_print("Hint: FORMAT, not WIPE or FACTORY RESET!");
ui_print(" ");
ui_print("If you decide to not format, unexpected issues may occur and given support will be limited.");
ui_print(" ");
ui_print("If you wish to proceed with the installer, please press the Volume UP button.");
ui_print("Otherwise, hold the Volume DOWN + POWER buttons for 7 seconds to force reboot.");

assert(run_program("/sbin/sh", "-c", "while true; do getevent -lc 1 | grep -q -m1 'KEY_VOLUMEUP' && exit 0; sleep 1; done"));

ui_print(" ");
ui_print("Please press Volume UP");
ui_print(" ");
ui_print("Proceeding...!");
ui_print(" ");
ui_print("****************************************************");
ui_print("       Q U A N T U M ---- R O M !");
ui_print("****************************************************");
show_progress(0.900000, 0);
ui_print("--Installing QuantumROM ${ROM_CODENAME}");
package_extract_file("super.img", "/dev/block/bootdevice/by-name/super");
ui_print("                                                        ");
show_progress(0.020000, 10);
ui_print("--Flashing ArtisanKRNL 3.5.1 with KSU Next!");
package_extract_file("boot.img", "/dev/block/bootdevice/by-name/boot");
package_extract_file("dtbo.img", "/dev/block/bootdevice/by-name/dtbo");
ui_print("                                                        ");
ui_print("                                                        ");
ui_print("Thanks for flashing, enjoy the ROM!");
ui_print("****************************************************");
ui_print("                                                        ");

show_progress(0.100000, 10);
set_progress(1.000000);
EOF

ok "updater-script generated"
