<section class="hero">
<div>
<h1>A Bluetooth remote release for the <em>Mamiya RZ67</em>.</h1>
<p class="lead">A small box on a coin cell plugs into the camera's remote port. An Android or iPhone app fires the shutter, holds it open for bulb, or runs a countdown.</p>
<p class="cta"><a class="btn p" href="build-guide.html">Build one</a><a class="btn" href="https://github.com/mhellevang/openrz67">View on GitHub</a></p>
</div>
<img src="img/on-camera.jpg" width="1280" height="1278" alt="The trigger mounted on the side of a Mamiya RZ67 Pro II, cable running to the remote port">
</section>

## What it does

- Instant release, bulb, and a countdown of up to 4 minutes.
- Runs on a CR2032. It sleeps between uses and wakes on a button press.
- Nothing to solder. The board comes assembled from a PCB assembly service, everything else plugs in.
- Firmware updates over Bluetooth.

<div class="shots">
<img src="img/app-direct.jpg" width="540" height="1188" alt="App in direct mode">
<img src="img/app-countdown.jpg" width="540" height="1188" alt="App in countdown mode">
<img src="img/app-bulb.jpg" width="540" height="1188" alt="App in bulb mode">
</div>

## Repositories

<div class="cards">
<div class="card"><h3>openrz67</h3><p>Board, case and firmware.</p><a href="https://github.com/mhellevang/openrz67">Repository</a></div>
<div class="card"><h3>openrz67-android</h3><p>Android app. APK on the releases page.</p><a href="https://github.com/mhellevang/openrz67-android">Repository</a> · <a href="https://github.com/mhellevang/openrz67-android/releases/latest">Download APK</a></div>
<div class="card"><h3>openrz67-ios</h3><p>iPhone app, built from source in Xcode for now.</p><a href="https://github.com/mhellevang/openrz67-ios">Repository</a></div>
</div>

## Documentation

- [Build guide](build-guide.md): parts, ordering the board, printing the case, flashing, the camera cable.
- [Camera port and Bluetooth protocol](protocol.md), for app developers and your own hardware.
- [Perfboard variant](perfboard.md), the same circuit with off-the-shelf parts. Not built yet.
