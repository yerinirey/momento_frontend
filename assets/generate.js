// gpt기반 생성: Puppeteer로 headless 캡처
import puppeteer from "puppeteer";
import path from "path";
import fs from "fs/promises";

const modelsDir = path.resolve("models"); // glb파일 경로
const outputDir = path.resolve("thumbnails");
const viewerPath = path.resolve("viewer.html");

const files = await fs.readdir(modelsDir);
const glbFiles = files.filter((file) => file.endsWith(".glb"));

if (!glbFiles.length) process.exit(1);

// puppeteer 브라우저 열기
const browser = await puppeteer.launch({ headless: "new" });
const page = await browser.newPage();

// html의 콘솔 메시지 확인용
page.on("console", (msg) => {
  console.log(`\tVIEWER - ${msg.type()}: ${msg.text()}`);
});

await page.setViewport({ width: 512, height: 512 });

// for~ of를 사용해야 파일 이름이 인식된다. for ~ in 문은 인덱스 번호로 인식한다.
for (const file of glbFiles) {
  // const modelPath = path.resolve(modelsDir, file);
  // const modelPath = path.resolve(modelsDir, file).replace(/\\/g, "/");
  // const viewerUrl = `file://${viewerPath}?model=file://${modelPath}`;
  // CORS에러때문에 file 을 통한 접근이 불가하다고 한다. 임의로 http-server를 통해 디버깅 >> http-server . -p 8080

  const modelPath = `http://localhost:8080/models/${file}`;
  const outputPath = path.join(outputDir, file.replace(".glb", ".png"));
  const viewerUrl = `http://localhost:8080/viewer.html?model=${encodeURIComponent(
    modelPath
  )}`;

  console.log(`GENERATE - ${file}`);

  await page.goto(viewerUrl);
  await new Promise((r) => setTimeout(r, 2000));
  await page.screenshot({ path: outputPath });

  console.log(`GENERATE END - ${file}\n`);
}

await browser.close();
console.log("GENERATE - 종료");
