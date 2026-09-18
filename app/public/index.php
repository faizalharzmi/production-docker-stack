<?php

declare(strict_types=1);

header('Content-Type: application/json');

echo json_encode([
    'service' => 'production-docker-stack-reference',
    'status' => 'ok',
    'message' => 'Containerised PHP application boundary is running.',
], JSON_THROW_ON_ERROR);
