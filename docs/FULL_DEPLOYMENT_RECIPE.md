# GLM 5.3 Full 4SPARK Cluster NIXAN 402K — Hugging Face/GitHub deployment recipe

**Официално и единствено име в този документ:** `GLM 5.3 Full 4SPARK Cluster NIXAN 402K`  

**Статус на документа:** готов проект за публикуване в Hugging Face и GitHub  
**Собственик на deployment рецептата:** Nikolay Lamburov / NIXAN  
**Точно display име, създадено в ZCode/Codex конфигурацията:** `GLM 5.3 Full 4SPARK Cluster NIXAN 402K`  
**Provider ID:** `nixan-glm53-max`  
**Runtime model ID / route:** `glm-5.3-long`  
**Deployment profile / recipe codename:** `C2aK/402000` (`C2aK/402K`)  
**Benchmark/harness key:** `local-glm53-c2ak`  
**Served model в vLLM:** `glm-5.3`  
**Официално публично заглавие:** `GLM 5.3 Full 4SPARK Cluster NIXAN 402K`  
**Официален repo slug:** `GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K`

> **Важно за авторството:** това не е ново обучение или нова quantization на GLM‑5.3.  
> Локалните тегла са публичният checkpoint `Tech2wild/GLM-5.3-Int4-Int8Mix`, snapshot
> `206507bbb047d8223964a0414cd83230c59428f9`. Оригиналният принос на NIXAN е
> deployment/serving рецептата с 402 000 token engine context, TP4 + DCP4 върху
> четири DGX Spark, request-level Max reasoning, изолиран LiteLLM маршрут,
> тестовата методика и реалните измервания от дълъг агентен правен benchmark.

---

## 1. Какво точно се публикува

Проектът има три отделни слоя и те трябва да бъдат разграничени публично:

1. **Базов модел:** `zai-org/GLM-5.3`.
2. **Quantized checkpoint:** `Tech2wild/GLM-5.3-Int4-Int8Mix`.
3. **GLM 5.3 Full 4SPARK Cluster NIXAN 402K deployment recipe (C2aK/402K profile):** конфигурация, patches, launcher-и, LiteLLM routing,
   benchmark methodology и измервания за 402K serving върху 4× NVIDIA DGX Spark.

Не трябва да се твърди, че NIXAN е създал базовия модел или Int4‑Int8Mix quant-а.
Правилното твърдение е:

> “GLM 5.3 Full 4SPARK Cluster NIXAN 402K is the exact local model profile name.
> C2aK/402K is its reproducible four-node deployment and benchmark recipe, built
> on the public Tech2wild GLM‑5.3 Int4‑Int8Mix checkpoint.”

### Препоръчителна стратегия за публикуване

- **GitHub:** кодът, launcher-ите, Dockerfile/patch instructions, конфигурациите,
  тестовете и benchmark резултатите.
- **Hugging Face:** model card / deployment card, benchmark summary и връзки към
  оригиналните weights и GitHub рецептата.
- **Weights:** по подразбиране не се дублират. Те вече са публични и са около
  405 GB в локалния snapshot. Публично mirror-ване е възможно по лиценза, но
  добавя огромен upload, storage и maintenance товар без техническа полза.

---

## 2. Произход и задължителни credits

### Base model

- **GLM‑5.3:** Z.AI / `zai-org/GLM-5.3`
- Архитектура: `GlmMoeDsaForCausalLM`
- 78 основни слоя плюс MTP layer
- 256 routed experts, 8 active experts/token
- Model config maximum: 1 048 576 positions

### Quantized weights

- **Current public checkpoint:** `Tech2wild/GLM-5.3-Int4-Int8Mix`
- Локален snapshot: `206507bbb047d8223964a0414cd83230c59428f9`
- 282 `safetensors` shards
- Локален checkpoint размер: **405 241 870 672 bytes**
- Формат: `compressed-tensors`, `pack-quantized`
- Experts: W4A16 group size 128
- Dense/attention/shared linears: W8A16 group size 128
- MTP: W8A16 channelwise
- Layer 0, routers, DSA indexers, selected norms и output head остават
  извън packed quantization според upstream quant recipe.

### Tooling and ideas

- `compressed-tensors` / `llm-compressor`: Neural Magic / Red Hat ecosystem
- Mixed-precision GLM layer map: QuantTrio lineage
- GB10 recipe/quant implementation: Tech2wild / Tony D.
- Base model license: GLM‑5.3 License от Z.AI

### License handling

Локалният checkpoint съдържа `GLM-5.3 License`. Лицензът разрешава използване,
копиране, модифициране и разпространение, при условие че copyright и license
notice се включат във всички съществени копия. При публична recipe публикация:

- копирай upstream `LICENSE` или добави `LICENSE-GLM-5.3`;
- добави `NOTICE.md` с точните credits;
- за твоя код използвай отделен лиценз, например Apache‑2.0 или MIT;
- не заменяй upstream model license с лиценза на recipe кода.

---

## 3. Точното име на модела и йерархията на имената

Точното display име, което беше създадено в ZCode/Codex конфигурацията, е:

```text
GLM 5.3 Full 4SPARK Cluster NIXAN 402K
```

Това е **името на локалния моделен профил**, видимо за потребителя. То не трябва
да се заменя с `C2aK/402K` в заглавието на модела.

Свързаните машинни идентификатори са:

```text
Provider ID:             nixan-glm53-max
Runtime model ID/route:  glm-5.3-long
Benchmark/harness key:   local-glm53-c2ak
vLLM served model:       glm-5.3
```

Официалното име на модела е **`GLM 5.3 Full 4SPARK Cluster NIXAN 402K`**. `C2aK/402000` остава само
технически идентификатор на deployment профила, а не отделно име на модела. `402000` е реалният vLLM `--max-model-len 402000`. `C2aK` трябва да
остане codename без измислено публично разшифроване, освен ако собственикът не
определи такова отделно.

Препоръчително публично заглавие на рецептата:

```text
GLM 5.3 Full 4SPARK Cluster NIXAN 402K — C2aK/402K Deployment Recipe for 4× DGX Spark
```

Препоръчително GitHub име:

```text
nixanlamburov/GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K
```

Препоръчително Hugging Face име:

```text
<HF_USERNAME>/GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K
```

Към датата на този документ GitHub CLI е вписан като `nixanlamburov`.
Hugging Face CLI е инсталиран (`hf 2.3.0`), но **няма активен login**.

---

## 4. Хардуерна топология

Проверената рецепта е за:

- 4× NVIDIA DGX Spark / GB10
- 128 GB unified memory на възел
- ARM64 / `sm121`
- ConnectX‑7 fabric
- 4-node native vLLM, без Ray
- Tensor Parallel: 4
- Decode Context Parallel: 4
- една активна sequence за long-job профила

Публичната документация не трябва да съдържа:

- реални частни IP адреси;
- API keys;
- Keychain service names;
- вътрешни usernames;
- Tailscale адреси;
- production database credentials.

Използвай placeholders:

```bash
MASTER_ADDR=<SPARK_RANK0_FABRIC_IP>
MASTER_PORT=29502
NODE_RANK=<0|1|2|3>
```

---

## 5. Проверен software stack

```text
Image: nixan/vllm-openai:nightly-aarch64-20261012
vLLM: 0.31.1rc1.dev296+gfe4df3df0
Torch: 2.13.0+cu130
CUDA: 13.0 family
Architecture: aarch64 / sm121
Attention backend: FLASHINFER_MLA_SPARSE_SM120
Reasoning parser: glm45
Tool parser: glm47
```

Това е custom/nightly stack. За публично възпроизводство трябва да се публикуват:

1. Dockerfile или точен image build manifest;
2. commit SHA на vLLM;
3. SHA‑256 на всеки patch/overlay;
4. patch application order;
5. health and rollback instructions;
6. предупреждение, че stock vLLM може да не работи на GB10/sm121.

Провереният overlay е монтиран read-only като:

```text
flashinfer_mla_sparse_sm120.py
→ vllm/v1/attention/backends/mla/flashinfer_mla_sparse_sm120.py
```

---

## 6. Точната C2aK/402K serving конфигурация

Санитизираната команда е:

```bash
vllm serve /models/glm-5.3 \
  --served-model-name glm-5.3 \
  --tensor-parallel-size 4 \
  --nnodes 4 \
  --node-rank "${NODE_RANK}" \
  --master-addr "${MASTER_ADDR}" \
  --master-port 29502 \
  --host 127.0.0.1 \
  --port 8002 \
  --max-model-len 402000 \
  --max-num-seqs 1 \
  --max-num-batched-tokens 2048 \
  --kv-cache-dtype fp8_ds_mla \
  --kv-cache-memory-bytes 5500000000 \
  --gpu-memory-utilization 0.85 \
  --decode-context-parallel-size 4 \
  --cp-kv-cache-interleave-size 1 \
  --attention-backend FLASHINFER_MLA_SPARSE_SM120 \
  --chat-template /templates/chat_template.jinja \
  --reasoning-parser glm45 \
  --tool-call-parser glm47 \
  --enable-auto-tool-choice \
  --uvicorn-log-level warning \
  --disable-uvicorn-access-log \
  --logprobs-mode raw_logprobs \
  --max-logprobs 20 \
  --no-enable-prefix-caching \
  -cc.cudagraph_mode=FULL_DECODE_ONLY
```

### Текущ default versus test override

Сървърът е стартиран с:

```json
{"reasoning_effort":"high"}
```

като default chat-template kwarg. Успешният правен benchmark обаче е изпълнен
с **request-level `reasoning_effort=max`**. Chat template-ът приема `low` и
`high`; всички други стойности, включително `max`, се нормализират към Max.

Това трябва да се опише точно:

- default service behavior: High;
- benchmark behavior: Max, зададено на request level;
- LiteLLM reservation guard: допуска само правилния alias/run и Max за benchmark.

---

## 7. Защо 402K, а не 1M

Checkpoint config рекламира 1 048 576 positions, но това не означава, че 1M е
оптимално или паметово безопасно върху 4× DGX Spark.

Избраното `402000`:

- позволява 335 440-token client input budget;
- оставя до 65 536 server-side output cap;
- осигурява приблизително 1 024 токена protocol/safety margin;
- работи без OOM и preemption;
- достига само 68% peak observed KV usage в пълния тест;
- оставя резерв за tool metadata и framework overhead.

Формулата на профила е:

```text
335 440 input
+65 536 output cap
=400 976
<402 000 engine limit
```

Това е operational context envelope, а не обещание, че всяка 402K заявка ще
има еднаква latency или качество.

---

## 8. Проверени runtime свойства

В пълния тест:

- max running requests: 1
- max waiting requests: 0
- preemptions: 0
- OOM: 0
- peak observed KV usage: 68%
- nonzero median prompt throughput: ~14 931 tok/s
- nonzero median decode throughput: ~14.2 tok/s
- stable engine idle after completion: PASS

Това доказва стабилно serving поведение за една изолирана дълга agent session.
Не доказва multi-user production throughput.

---

## 9. Какво е добро и какво трябва да се подобри

### Добро

- TP4 + DCP4 се държи стабилно при 276K real prompt.
- FP8 MLA KV cache не дава preemption.
- 402K envelope има достатъчен резерв.
- Long-running Codex tool session завършва с истински `turn.completed`.
- Инструменталният JSON и финалният artifact са проверими по hash.

### Неоптимално

- Automatic Prefix Caching е изключен.
- `max_num_batched_tokens=2048` е консервативно за огромен single-sequence prefill.
- Max reasoning е използван и за механични retrieval turns.
- 61 model calls обработват 9.39M cumulative prompt tokens.
- Първата цяла чернова идва едва след 4:43 часа.
- Output cap 65 536 е много по-висок от измерения максимум 10 706.
- Text-only профилът е виждал `view_image`, което е довело до router refusal.

### Следваща canary версия

Без да се променя работещият production lane, тествай отделно:

```bash
--enable-prefix-caching
--max-num-batched-tokens 8192
```

След това A/B:

```bash
--max-num-batched-tokens 16384
```

Измервай:

- time to first full draft;
- total prompt tokens;
- request median/p90;
- peak KV;
- preemptions;
- source traceability;
- final technical score.

---

## 10. Препоръчителна публична repository структура

```text
GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K/
├── README.md
├── LICENSE
├── LICENSE-GLM-5.3
├── NOTICE.md
├── ATTRIBUTION.md
├── SECURITY.md
├── CHANGELOG.md
├── recipe/
│   ├── serve-rank.sh
│   ├── docker-compose.example.yml
│   ├── env.example
│   ├── chat_template.jinja
│   ├── vllm-args.txt
│   └── healthcheck.sh
├── patches/
│   ├── README.md
│   └── flashinfer_mla_sparse_sm120.py.patch
├── gateway/
│   ├── litellm.example.yaml
│   └── reservation-policy.md
├── benchmarks/
│   ├── kalina-legal-benchmark.md
│   ├── metrics-summary.json
│   └── reproduction.md
└── docs/
    ├── architecture.md
    ├── troubleshooting.md
    └── rollback.md
```

**Не качвай weights в GitHub.** GitHub блокира обикновени Git файлове над
100 MiB и този checkpoint е стотици гигабайти. GitHub е за recipe/code/docs.
Weights принадлежат в Hugging Face/Xet или друг model registry.

---

## 11. Готов Hugging Face Model Card header

За recipe-only HF repository:

```yaml
---
license: apache-2.0
base_model:
- Tech2wild/GLM-5.3-Int4-Int8Mix
pipeline_tag: text-generation
library_name: vllm
tags:
- glm
- glm-5.3
- dgx-spark
- gb10
- vllm
- long-context
- 402k-context
- tensor-parallel
- decode-context-parallel
- fp8-kv-cache
- agentic
- legal-benchmark
---

# GLM 5.3 Full 4SPARK Cluster NIXAN 402K — C2aK/402K Deployment Recipe for 4× DGX Spark

This repository contains a reproducible deployment and benchmark recipe.
It does not claim authorship of the GLM-5.3 base model or the Int4-Int8Mix
quantized weights.

- Base model: zai-org/GLM-5.3
- Quantized checkpoint: Tech2wild/GLM-5.3-Int4-Int8Mix
- NIXAN contribution: 402K serving profile, 4-node TP4+DCP4 deployment,
  LiteLLM isolation, Codex integration, and long-form technical benchmark.

See the GitHub repository for launchers, patches, benchmark methodology,
security notes and reproducibility instructions.
```

Ако се качат unchanged mirror weights, не използвай Apache‑2.0 за model weights.
Repo card трябва да е:

```yaml
license: other
license_name: glm-5.3
license_link: https://huggingface.co/zai-org/GLM-5.3/blob/main/LICENSE
```

и изрично да казва, че това е mirror на Tech2wild checkpoint, не нов quant.

---

## 12. Готов GitHub README opening

```markdown
# GLM 5.3 Full 4SPARK Cluster NIXAN 402K

A reproducible 402,000-token vLLM deployment recipe for the full GLM‑5.3
Int4‑Int8Mix checkpoint across four NVIDIA DGX Spark GB10 nodes.

This repository publishes deployment engineering, not a new base model and
not a new quantization. The weights come from
`Tech2wild/GLM-5.3-Int4-Int8Mix`; the base model is `zai-org/GLM-5.3`.

## Verified result

A six-hour closed-world Bulgarian legal-agent benchmark completed in
5:29:52 with a 276,426-token peak prompt, 0 preemptions, 0 OOM events and a
hash-verified final artifact. The quality scores in this repository are
technical artifact scores only; they are not legal opinions or claims of
legal correctness.
```

---

## 13. Публикуване в GitHub — препоръчителен процес

GitHub CLI вече е вписан като `nixanlamburov`.

```bash
mkdir -p ~/Projects/GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K
cd ~/Projects/GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K

git init
git branch -M main

# Добави само recipe/code/docs — без weights, secrets, logs и private IPs.
git add README.md LICENSE NOTICE.md ATTRIBUTION.md recipe patches gateway benchmarks docs
git commit -m "Initial public GLM 5.3 Full 4SPARK Cluster NIXAN 402K C2aK/402K recipe"

gh repo create nixanlamburov/GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K \
  --public \
  --source=. \
  --remote=origin \
  --push
```

Преди push:

```bash
git status
git diff --cached
rg -n -i 'token|api[_-]?key|password|secret|10\.[0-9]+\.[0-9]+\.[0-9]+' .
```

Не публикувай:

- `.env`;
- Keychain exports;
- LiteLLM master key;
- реални вътрешни адреси;
- клиентски документи;
- raw private transcripts;
- private legal corpora.

---

## 14. Публикуване в Hugging Face

Към момента CLI не е логнато. Първата стъпка е:

```bash
hf auth login
hf auth whoami
```

Създай първо **private** repository, докато провериш card-а:

```bash
hf repos create <HF_USERNAME>/GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K --private
```

Recipe-only upload:

```bash
hf upload <HF_USERNAME>/GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K \
  ./hf-model-card-package .
```

След проверка може да стане public от Hugging Face settings.

### Ако все пак се mirror-нат 405 GB weights

Препоръчителната команда за стотици GB е resumable large-folder upload:

```bash
hf upload-large-folder \
  <HF_USERNAME>/GLM-5.3-Full-4SPARK-Cluster-NIXAN-402K-Mirror \
  /path/to/model-snapshot \
  --num-workers 4
```

Преди това:

1. провери свободното място и upload bandwidth;
2. премахни `.cache`, `.lock` и временни файлове;
3. включи upstream `LICENSE`, `README`, `.gitattributes`;
4. добави `MIRROR_NOTICE.md`;
5. публикувай manifest с SHA‑256 на всички 282 shards;
6. започни private;
7. не променяй config/tokenizer без нов revision и обяснение.

Официални ръководства:

- Hugging Face upload: https://huggingface.co/docs/huggingface_hub/main/guides/upload
- Hugging Face CLI: https://huggingface.co/docs/huggingface_hub/en/guides/cli
- GitHub repository limits: https://docs.github.com/en/repositories/creating-and-managing-repositories/repository-limits
- GitHub existing project: https://docs.github.com/en/migrations/importing-source-code/using-the-command-line-to-import-source-code/adding-locally-hosted-code-to-github

---

## 15. Release checklist

### Technical

- [ ] Pin vLLM commit and image digest.
- [ ] Publish all applied patches with hashes.
- [ ] Publish sanitized 4-rank launcher.
- [ ] Add health, drain and rollback commands.
- [ ] Add exact checkpoint revision.
- [ ] Add measured metrics, not estimates.
- [ ] Separate baseline from future canary tuning.
- [ ] Mark prefix caching as disabled in the verified release.
- [ ] Mark `max_num_batched_tokens=2048` as verified baseline.
- [ ] Mark 8192/16384 as recommendations, not proven improvements.

### Attribution and licensing

- [ ] Credit Z.AI.
- [ ] Credit Tech2wild / Tony D.
- [ ] Credit QuantTrio layer-map lineage.
- [ ] Credit Neural Magic / Red Hat compressed-tensors tooling.
- [ ] Include GLM‑5.3 License.
- [ ] Use a separate license for NIXAN scripts.
- [ ] Do not claim quant authorship.

### Benchmark

- [ ] State that the legal case is synthetic/closed-world.
- [ ] Do not publish private customer data.
- [ ] State that ratings are technical only.
- [ ] Do not imply legal correctness or lawyer approval.
- [ ] Publish exact run ID, hashes and environment version.
- [ ] Separate measured facts from recommendations.

---

## 16. Recommended first public release

**Version:** `v0.1.0-c2ak402k`  
**Scope:** recipe and benchmark only, no duplicated weights  
**GitHub:** public  
**Hugging Face:** private review, then public model/deployment card  
**Weights:** reference the existing Tech2wild repository  
**Next release:** prefix-cache + 8192 batched-token canary after A/B validation

Recommended release statement:

> This is the first NIXAN publication of the `GLM 5.3 Full 4SPARK Cluster NIXAN 402K` model profile and its verified 402K deployment recipe.
> It documents a verified 402,000-token engine configuration for GLM‑5.3
> Int4‑Int8Mix on four DGX Spark nodes, including a completed long-form
> Bulgarian legal-agent benchmark. It does not introduce new model weights
> or claim legal correctness.

---

## 17. Final recommendation

Публикувай първо **рецептата**, а не 405 GB duplicate weights.

Най-ценният оригинален резултат е:

- operational 402K configuration;
- TP4 + DCP4 on four GB10 nodes;
- request-level Max reasoning path;
- isolated LiteLLM benchmark reservation;
- end-to-end Codex tool workflow;
- six-hour legal benchmark data;
- measured context, latency, KV and output behavior;
- engineering recommendations based on real execution.

Това е достатъчно значим и възпроизводим open-source contribution само по себе си.
