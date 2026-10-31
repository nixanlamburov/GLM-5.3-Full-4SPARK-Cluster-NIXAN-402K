# GLM 5.3 Full 4SPARK Cluster NIXAN 402K — технически отчет от теста „Отговор на искова молба“

**Официално и единствено име в този документ:** `GLM 5.3 Full 4SPARK Cluster NIXAN 402K`  

**Run ID:** `20261030T123433Z-a52f56954d33`  
**Точно display име на модела:** `GLM 5.3 Full 4SPARK Cluster NIXAN 402K`  
**Underlying checkpoint:** `Tech2wild/GLM-5.3-Int4-Int8Mix`  
**Provider ID / runtime route:** `nixan-glm53-max` / `glm-5.3-long`  
**Deployment profile:** `C2aK/402000`, 4× NVIDIA DGX Spark  
**Клиент:** Codex CLI  
**Маршрут:** Codex → LiteLLM → vLLM → GLM‑5.3  
**Reasoning:** request-level `max`  
**Статус:** `COMPLETE`, exit code 0, `turn.completed`, delivery complete  
**Дата:** 30.10.2026

> **Критично уточнение:** всички оценки в този документ са оценки на
> техническото поведение на модела, надеждността на агентния процес,
> проследимостта и формата на артефакта. Те не са правна оценка, не са
> адвокатско становище и не доказват юридическа правилност по българското право.

---

## 1. Цел на теста

Тестът проверява дали голям локален модел може да изпълни продължителна,
многостъпкова правна задача в Codex среда:

- да прочете frozen corpus;
- да използва инструменти за търсене, четене и OCR;
- да следва професионална методика на Калина;
- да изчисли процесуален срок;
- да създаде пълен проект на отговор по чл. 131 ГПК;
- да подготви доказателствени искания;
- да посочи слабости на позицията;
- да формулира въпроси към адвоката и клиента;
- да запише, провери и публикува `answer.md`;
- да приключи native Codex turn нормално.

Казусът е затворен synthetic benchmark с дата на сценария 21.10.2026 г.
Не е извършвано подаване, подписване, изпращане или реално процесуално действие.

---

## 2. Сценарият

Фиктивният клиент е дружество, срещу което е предявен иск от етажна собственост
за:

1. вноски за няколко апартамента за 2023–2025 г.;
2. мораторна лихва;
3. разходи за басейн;
4. свързана лихва.

Клиентската начална теза е:

- давност за 2023 г.;
- липса на кворум на събрание от 20.04.2024 г.;
- етажната собственост сама е решила да поддържа басейна.

Моделът трябва да провери дали тези твърдения са подкрепени, да намери
насрещните доказателства и да не защитава механично първоначалната позиция.

---

## 3. Тестова среда

### Изолация

- OpenClaw е спрян.
- LiteLLM backend е резервиран само за точния run ID и `kalina.codex`.
- Чужди GLM заявки се отказват преди inference.
- `max_num_seqs=1`.
- Няма waiting requests по време на прогона.
- Няма външни модели или cloud fallback.

### Closed-world ограничения

Моделът няма достъп до:

- интернет;
- АПИС;
- живи регистри;
- лична памет;
- външни LLM;
- реална поща;
- непредоставени съдебни източници.

Това позволява възпроизводим тест, но не пълна реална адвокатска проверка.

### Инструменти

- `list-docs`
- `search-docs`
- `read-doc`
- guarded OCR/extract
- role/workflow reader
- deterministic deadline helper
- draft writer
- finalize/readback
- shell операции в ограничената работна среда

---

## 4. Моделна и serving конфигурация

```text
Model alias: glm-5.3-long
Engine max context: 402000
Codex input cap: 335440
Server output cap: 65536
Tensor Parallel: 4
Decode Context Parallel: 4
Max sequences: 1
Max batched tokens: 2048
KV cache: fp8_ds_mla
KV memory: 5.5 GB/rank
GPU memory utilization: 0.85
Prefix caching: disabled
Attention backend: FLASHINFER_MLA_SPARSE_SM120
CUDA graph: FULL_DECODE_ONLY
```

Checkpoint:

```text
GLM-5.3 Int4-Int8Mix
282 safetensors shards
405,241,870,672 bytes
W4A16 experts
W8A16 dense/attention
BF16 activations
```

---

## 5. Подготовка преди старта

Преди реалния run са изпълнени:

1. рестарт на Mac Studio;
2. post-reboot health checks;
3. проверка на LiteLLM custom admission callback;
4. проверка, че GLM backend е idle;
5. спиране на OpenClaw app и containers;
6. full unit test pass на harness и toolbox;
7. offline Codex native-provider/tool roundtrip;
8. проверка, че request wire съдържа `reasoning_effort=max`;
9. exact-profile preflight `READY`;
10. активиране на backend reservation за точния run.

Това отделя средови проблеми от моделно поведение.

---

## 6. Хронология на теста

### Старт

- 13:37:57 Europe/Madrid
- hard deadline: 19:37:57
- wall budget: 6 часа

### Междинен checkpoint

- записан около 14:03:30
- 3 572 bytes
- наблюдаван преди 25% milestone

### Evidence acquisition

Моделът прекарва основната част от времето в:

- търсене по corpus;
- четене на конкретни D-ID;
- извличане на OCR;
- сравнение на противоречащи протоколи;
- проверка на вноски, плащания и басейнови разходи;
- проверка на давност и признаване на задължение.

### Първа пълна чернова

- записана около 18:21:12
- 35 718 bytes
- milestone за 50% е пропуснат

### Втора чернова

- записана около 18:34:06
- 36 328 bytes
- съдържа целеви поправки и видими формули

### Финализиране

- `answer.md` публикуван около 18:58:54
- 36 328 bytes
- byte-identical с `draft-v2.md`
- SHA‑256:
  `ce4ab84c776ce41d82761c3f42a06f366ea61c072175511abbee647355ec2de2`

### Край

- `turn.completed` около 19:07:45
- lifecycle complete около 19:07:50
- общо време: **5:29:52.78**
- технически резерв преди hard deadline: около 30 минути

---

## 7. Пълни измерени метрики

| Метрика | Стойност |
|---|---:|
| Wall time | 19 792.78 s |
| Успешни моделни заявки | 61 |
| Cumulative prompt tokens | 9 394 780 |
| Cumulative completion tokens | 60 268 |
| Последен prompt | 276 426 |
| Median prompt | 149 319 |
| P90 prompt | 255 851 |
| Max single completion | 10 706 |
| Median completion | 760 |
| P90 completion | 1 561 |
| Median model request | 285.688 s |
| P90 model request | 517.631 s |
| Max model request | 1 182.136 s |
| Median nonzero decode throughput | ~14.2 tok/s |
| Median nonzero prompt throughput | ~14 931 tok/s |
| Peak observed KV usage | 68% |
| Preemptions | 0 |
| OOM | 0 |
| Waiting requests | 0 |
| Tool/shell commands | 135 |
| Nonzero shell exits | 0 |
| `search-docs` | 47 |
| `read-doc` | 51 |
| OCR extractions | 2 |
| Draft writes | 3 |
| Finalize operations | 1 |

В LiteLLM има два zero-token failure реда от deliberate admission probes.
Те не са model-task failures.

---

## 8. Контекстово поведение

Prompt-ът нараства приблизително:

```text
16.8K → 67K → 149K → 220K → 276.4K
```

Последният prompt използва около:

```text
276,426 / 335,440 = 82.4%
```

от client input budget.

При пълния output cap:

```text
276,426 + 65,536 = 341,962
```

което остава под 402 000 engine limit.

### Заключение за контекста

- няма context overflow;
- няма доказана compaction;
- няма OOM;
- няма preemption;
- 402K е достатъчен;
- повече context не би решило latency проблема.

Основният inefficiency е cumulative prompt replay:

```text
9,394,780 / 276,426 ≈ 34×
```

При всяка следваща агентна стъпка голяма част от натрупания prefix се подава
отново. Automatic Prefix Caching е изключен.

---

## 9. Поведение на модела

### Положително

1. Поддържа coherence при prompt над 276K.
2. Не прекратява след checkpoint.
3. Намира неблагоприятни за клиента доказателства.
4. Коригира клиентската теза за давността.
5. Различава кворум от мнозинство за конкретно решение.
6. Изгражда две пълни версии.
7. Използва source identifiers.
8. Извършва readback и hash verification.
9. Завършва с истински `turn.completed`.
10. Не предизвиква engine OOM/preemption.

### Негативно

1. Чете прекалено дълго преди drafting.
2. Пропуска draft и answer milestones.
3. Използва 98 отделни search/read операции.
4. Max reasoning е използван и за механични turns.
5. Прави един недопустим `view_image` опит при text-only endpoint.
6. 60 268 generated tokens са около 7.15× финалния документ.
7. Последователните long-context turns правят latency непредвидима.
8. Advisory deadline controller не е достатъчно принудителен.

---

## 10. Технически свойства на финалния резултат

`answer.md`:

- 36 328 bytes
- 3 455 думи
- 8 430 GLM tokenizer tokens
- 233 реда
- 23 headings
- 5 изискани deliverable части
- 29 уникални D-ID източника
- 72 source mentions
- 50 реда с citation references
- 69 парични стойности
- 61 дати
- множество явни аритметични формули
- валиден UTF‑8
- hash-verified readback
- final е идентичен с проверения `draft-v2.md`

### Силни технически страни

- добра структура;
- traceability;
- видими формули;
- ясно отделени слабости;
- честно маркирани ограничения;
- отделен списък на доказателствата;
- отделни въпроси за адвоката и клиента.

### Технически ограничения

- не е filing-ready;
- има полета за адрес и телефон;
- има synthetic `.example` email;
- има редакционни/езикови грешки;
- lawyer memo и court filing не са разделени като два файла;
- решаващи OCR страници не са визуално сверени;
- няма independent legal validation;
- няма live legal research;
- quality status е `NOT_SCORED`.

---

## 11. Оценки — само технически

| Област | Техническа оценка |
|---|---:|
| Клъстърна стабилност | 9.3/10 |
| Контекстов капацитет | 8.8/10 |
| KV/memory tuning | 8.5/10 |
| Raw decode за размера | 7.0/10 |
| End-to-end latency | 3.0/10 |
| Agent workflow efficiency | 3.0/10 |
| Source traceability | 8.8/10 |
| Review artifact quality | 8.2/10 |
| Direct filing readiness | ~6.0/10 |
| Current production profile | 6.2/10 |
| Потенциал след оптимизация | 8.5+/10 |

Тези числа не оценяват:

- правилността на правния извод;
- актуалността на законодателството;
- валидността на съдебната практика;
- адвокатската стратегия;
- вероятността за успех по дело;
- съответствието с професионална правна отговорност.

---

## 12. Какво трябва да се промени в serving профила

### P0

1. Canary с `--enable-prefix-caching`.
2. A/B с `--max-num-batched-tokens 8192`.
3. След успешен A/B — 16384.
4. Премахване на `view_image` от text-only tool schema.
5. Output cap 24 576 за draft/final.
6. Retrieval output cap 8 192–12 288.
7. Phase-enforced drafting.

### Не променяй без A/B

- 402K context;
- TP4;
- DCP4;
- FP8 MLA KV;
- 5.5 GB/rank KV;
- 0.85 GPU utilization;
- single-sequence benchmark lane.

Тези настройки са били стабилни.

---

## 13. Как задачата трябва да бъде структурирана

Една непрекъсната 276K agent session не е оптималната production форма.

### Фаза 1 — Evidence acquisition

Изход:

```text
EVIDENCE_LEDGER.json
TIMELINE.md
SOURCE_EXCERPTS.md
CONTRADICTIONS.md
```

Цел:

- документи;
- факти;
- дати;
- числа;
- source provenance;
- OCR status.

Reasoning: `high`.

### Фаза 2 — Legal issue matrix

Изход:

```text
CLAIM_DEFENSE_MATRIX.md
BURDEN_MATRIX.md
DRAFT_PLAN.md
```

Цел:

- искове;
- възражения;
- тежест на доказване;
- риск;
- missing facts;
- strategy choices.

Reasoning: `max`.

### Фаза 3 — Пълна чернова

Вход:

- TASK;
- evidence ledger;
- issue matrix;
- само ключовите excerpts.

Изход:

```text
draft-v1.md
```

Reasoning: `max`.

Черновата трябва да бъде задължителна до 35–40% от wall budget.

### Фаза 4 — Mechanical QA

Проверки:

- всички суми;
- всички дати;
- placeholders;
- D-ID references;
- петте deliverable части;
- имена;
- OCR caveats;
- filing fields.

Reasoning: `high` или deterministic scripts.

### Фаза 5 — Final legal QA

Вход:

- draft;
- QA report;
- key sources.

Изход:

```text
court-filing.md
lawyer-memo.md
answer.md
```

Reasoning: `max`.

---

## 14. Препоръчителен паралелен модел

Най-подходящата комбинация за наличния хардуер е:

### Qwen3.6‑27B на Mac Studio

Роля:

- постоянен fast model;
- document routing;
- OCR orchestration;
- search;
- evidence ledger;
- timeline;
- numeric/date validation;
- placeholder checking;
- browser/tool work;
- кратки интерактивни отговори.

Препоръчителен профил:

```text
4-bit
64K–96K default context
1 concurrent request initially
8K–12K output cap
text-only always-on profile
vision profile on demand
```

### GLM 5.3 Full 4SPARK Cluster NIXAN 402K

Роля:

- сложен правен синтез;
- противоречиви доказателства;
- стратегия;
- пълна чернова;
- final adversarial review;
- дълъг контекст при реална нужда.

### Защо не GLM Flash едновременно

GLM Full вече използва четирите Spark възела с TP4+DCP4. Паралелен GLM Flash
би конкурирал:

- unified memory;
- KV pool;
- междовъзлова комуникация;
- service capacity.

Qwen на Mac Studio е по-комплементарен, защото не отнема ресурси от Spark
клъстъра.

---

## 15. Препоръчителен дву-моделен workflow

```text
1. Qwen:
   OCR routing → retrieval → evidence ledger → timeline → issue candidates

2. GLM 5.3 Full 4SPARK Cluster NIXAN 402K (reasoning=max):
   legal synthesis → strategy → draft-v1

3. Qwen:
   arithmetic/date/source/placeholder QA

4. GLM 5.3 Full 4SPARK Cluster NIXAN 402K (reasoning=max):
   targeted correction → final legal review → answer.md
```

Целеви GLM контекст:

```text
30K–100K
```

а не автоматично 250K–300K.

Целеви GLM turns:

```text
2–6 големи turns
```

вместо 61 дълги turns.

---

## 16. Phase controller за 6-часов бюджет

| Бюджет | Задължителен резултат |
|---|---|
| 0–25% | evidence ledger |
| 25–40% | full draft-v1 |
| 40–65% | targeted verification |
| 65–80% | draft-v2 + automated QA |
| 80–90% | answer.md + readback |
| 90–100% | recovery reserve only |

След 45% broad search трябва да се забрани, освен за конкретна доказателствена
липса. След 80% не трябва да се започва ново проучване.

---

## 17. A/B цели за следващ тест

| Метрика | Текущо | Цел |
|---|---:|---:|
| Prompt replay factor | ~34× | ≤5× |
| First full draft | 4:43 h | ≤2:00 h |
| Final completion | 5:30 h | ≤3:00 h |
| Median request | 4:46 min | ≤90 s за retrieval |
| Tool commands | 135 | ≤70 |
| Search/read operations | 98 | ≤50 |
| Source IDs in final | 29 | да не намаляват |
| Preemptions/OOM | 0/0 | 0/0 |
| Legal quality score | NOT_SCORED | independent review |

---

## 18. Какво може да се публикува публично

Може да се публикува:

- synthetic task description;
- sanitized tool architecture;
- exact serving flags;
- aggregate metrics;
- redacted timeline;
- technical scorecard;
- final artifact statistics;
- SHA‑256;
- recommendations.

Не трябва да се публикува без отделна проверка:

- реална клиентска информация;
- частни документи;
- private emails;
- internal IPs;
- API keys;
- raw production logs;
- hidden benchmark answer keys;
- съдебен документ, който може да бъде объркан с реален filing.

В public report трябва да присъства:

> “All ratings are technical artifact and systems-engineering ratings only.
> They are not legal opinions and do not establish legal correctness under
> Bulgarian law.”

---

## 19. Финално инженерно заключение

Тестът доказва три неща:

1. **Моделът може да държи и използва 276K реален agent context.**
2. **Четирите DGX Spark могат да обслужат профила стабилно без OOM/preemption.**
3. **Codex workflow може да произведе hash-verified пълен артефакт и да завърши.**

Тестът не доказва:

1. юридическа правилност;
2. оптимална latency;
3. production efficiency;
4. multi-user throughput;
5. качество спрямо BF16 base или cloud frontier models.

Основният bottleneck е orchestration:

- repeated prompt prefill;
- прекалено много tool turns;
- Max reasoning навсякъде;
- късно drafting;
- липса на batch retrieval;
- липса на задължителни phase gates.

Следващата версия трябва да запази модела и контекста, но да промени pipeline-а.
Най-добрата практическа система е **Qwen3.6‑27B за retrieval/QA + GLM 5.3 Full 4SPARK Cluster NIXAN 402K
за synthesis/draft/final review**.
