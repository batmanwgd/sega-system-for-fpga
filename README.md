I found this zip file from many years ago on my old laptop that I was giving away; might as well throw it up on github in case anyone has a use for Sega in Verilog that's synthesizable. According to the timestamps, I was a teenager when I worked on this, so the quality of the code isn't that great. Also, as I recall, the display was something very specific to the [weirdo board we had](http://www.xess.com/prods/prod014_4.php), where half of the SRAM address and data lines were multiplexed to drive a display.

The only bug I can recall was that in Double Dragon, the heads and torsos on some characters would be swapped, but that probably indicates that other games don't work perfectly, even if the bugs aren't as visually obvious.

The architecture is a simple six stage pipeline. The major difference between our design and a standard five stage pipeline is that we translate Z80 ops into RISC uops and execute them on a small RISC core. There's a one stage queue between the translation and the RISC front-end, because we can generate multiple RISC uops per Z80 op.

After looking more closely at this archive, it appears to be missing a few things. Not too surprising, considering my backup and archival practices as a teenager. I suspect I won't fill in the blanks any time soon; pull requests welcome, though.
