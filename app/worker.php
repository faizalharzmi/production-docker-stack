<?php

declare(strict_types=1);

$redis = new Redis();
$redis->connect(getenv('REDIS_HOST') ?: 'redis', (int) (getenv('REDIS_PORT') ?: 6379), 2.0);

fwrite(STDOUT, "worker connected to Redis\n");

while (true) {
    $job = $redis->blPop(['reference_jobs'], 5);

    if ($job === false) {
        continue;
    }

    $parts = array_values($job);
    $payload = $parts[1] ?? null;
    if (!is_string($payload)) {
        continue;
    }

    fwrite(STDOUT, sprintf("processed reference job: %s\n", $payload));
}
