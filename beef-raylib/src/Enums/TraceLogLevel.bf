using System;

namespace Raylib;

/// Trace log level
[CRepr]
public enum TraceLogLevel : int32
{
    /// Display all logs
    All = 0,
    /// Trace logging, intended for internal use only
    Trace,
    /// Debug logging, used for internal debugging, it should be disabled on release builds
    Debug,
    /// Info logging, used for program execution info
    Info,
    /// Warning logging, used on recoverable failures
    Warning,
    /// Error logging, used on unrecoverable failures
    Error,
    /// Fatal logging, used to abort program: exit(EXIT_FAILURE)
    Fatal,
    /// Disable logging
    None
}